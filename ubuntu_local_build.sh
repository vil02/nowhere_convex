#!/bin/bash

readonly FILE_NAME="nowhere_convex"
readonly FILE_EXT=".tex"
pdflatex -interaction=batchmode -draftmode "$FILE_NAME$FILE_EXT"
bibtex $FILE_NAME
pdflatex -interaction=batchmode -draftmode "$FILE_NAME$FILE_EXT"
pdflatex -interaction=batchmode "$FILE_NAME$FILE_EXT"
