ARG PANDOC_VERSION
FROM registry.gitlab.com/jwhb/docker-pandoc:$PANDOC_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN dnf install -y \
    latexmk \
    texlive-babel-german \
    texlive-biblatex-lni \
    texlive-ccicons \
    texlive-cleveref \
    texlive-cm-super \
    texlive-libertine \
    texlive-lni \
    texlive-mwe \
    texlive-nag \
  && dnf clean all

