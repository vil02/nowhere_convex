#!/bin/bash

set -e
set -u

script_lock=$(dirname "${0}")/"build_lock_dir"
readonly script_lock

declare -r file_name="nowhere_convex"
declare -r file_ext=".tex"

function is_already_running()
{
    declare -i return_value=0
    test -d "${script_lock}" ||
    {
        return_value=1
    }
    return "${return_value}"
}

function create_lock()
{
    mkdir "${script_lock}" ||
    {
        printf "Can not create lock\n"
        exit 2
    }
}

function remove_lock()
{
    rm -rf "${script_lock}" ||
    {
        printf "Can not remove lock\n"
        exit 3
    }
}

if is_already_running
then
    printf "Can not acquire lock (another instance is running?) - exiting.\n"
    exit 1
fi

create_lock

pdflatex -interaction=batchmode -draftmode "$file_name$file_ext" || true
bibtex $file_name || true
pdflatex -interaction=batchmode -draftmode "$file_name$file_ext" || true

pdflatex -interaction=batchmode "$file_name$file_ext" ||
{
    remove_lock
    printf "Error while building document\n"
    exit 4
}

remove_lock
