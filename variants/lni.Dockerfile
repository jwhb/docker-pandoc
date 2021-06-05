ARG PANDOC_VERSION
FROM registry.gitlab.com/jwhb/docker-pandoc:$PANDOC_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN dnf install -y \
    texlive-ccicons \
    texlive-cleveref \
    texlive-libertine \
    texlive-lni \
    texlive-biblatex-lni \
    texlive-nag \
    texlive-mwe \
    texlive-cm-super \
  && dnf clean all

