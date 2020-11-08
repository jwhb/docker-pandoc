ARG PANDOC_VERSION
FROM registry.gitlab.com/jwhb/docker-pandoc:$PANDOC_VERSION

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
  && dnf clean all

RUN pip3 install --no-cache-dir pandoc-include==0.8.3

RUN curl -Lo /tmp/pandoc-include-code.tar.gz \
    "https://github.com/owickstrom/pandoc-include-code/releases/download/v1.2.0.2/pandoc-include-code-linux-ghc8-pandoc-1-19.tar.gz" \
  && tar -xvzf /tmp/pandoc-include-code.tar.gz -C /usr/local/bin/ \
  && rm /tmp/pandoc-include-code.tar.gz

RUN curl -Lo /tmp/Eisvogel.tar.gz \
    "https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v1.5.0/Eisvogel.tar.gz" \
  && mkdir -p "$HOME/.pandoc/templates" \
  && tar -xvzf /tmp/Eisvogel.tar.gz -C "$HOME/.pandoc/templates" eisvogel.tex \
  && rm /tmp/Eisvogel.tar.gz \
  && mv "$HOME/.pandoc/templates/eisvogel.tex" "$HOME/.pandoc/templates/eisvogel.latex"

