ARG PANDOC_VERSION
FROM registry.gitlab.com/jwhb/docker-pandoc:$PANDOC_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN dnf install -y \
    python3-pip \
    texlive-adjustbox \
    texlive-babel-german \
    texlive-background \
    texlive-bidi \
    texlive-collectbox \
    texlive-csquotes \
    texlive-everypage \
    texlive-filehook \
    texlive-footmisc \
    texlive-footnotebackref \
    texlive-framed \
    texlive-fvextra \
    texlive-ly1 \
    texlive-mdframed \
    texlive-mweights \
    texlive-needspace \
    texlive-pagecolor \
    texlive-sourcecodepro \
    texlive-sourcesanspro \
    texlive-titling \
    texlive-ucharcat \
    texlive-ulem \
    texlive-unicode-math \
    texlive-upquote \
    texlive-xecjk \
    texlive-xurl \
    texlive-enumitem-zref \
  && dnf clean all \
  && pip3 install --no-cache-dir pandoc-include==0.8.7 \
  && curl -Lo /tmp/pandoc-include-code.tar.gz \
    "https://github.com/owickstrom/pandoc-include-code/releases/download/v1.2.0.2/pandoc-include-code-linux-ghc8-pandoc-1-19.tar.gz" \
  && tar -xvzf /tmp/pandoc-include-code.tar.gz -C /usr/local/bin/ \
  && rm /tmp/pandoc-include-code.tar.gz \
    \
  && mkdir -p "$HOME/.pandoc/templates" \
  && curl -L \
    "https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v2.0.0/Eisvogel-2.0.0.tar.gz" \
  | tar -xvz -C "$HOME/.pandoc/templates" eisvogel.latex \
  && ln -s eisvogel.latex "$HOME/.pandoc/templates/eisvogel.tex"

