FROM gitpod/workspace-base:2024-01-20-13-44-18

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  texlive-latex-extra=2021.20220204-1 \
  chktex=1.7.6-4 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER gitpod
