# build pandoc rpm with fpm
FROM ruby:alpine AS rpmbuild

ARG PANDOC_VERSION

# check if pandoc version is set
RUN test -n "$PANDOC_VERSION" || (echo "ERROR: PANDOC_VERSION not set" && exit 1)

# install fpm and build tools
RUN apk --no-cache add \
  make=4.3-r0 \
  gcc=9.3.0-r2 \
  libc-dev=0.7.2-r3 \
  wget=1.20.3-r1 \
  rpm=4.15.1-r2
RUN gem install fpm:1.11.0

# make rpm
WORKDIR /tmp/rpmbuild
COPY Makefile /tmp/rpmbuild
RUN make rpm PKG_VERSION=$PANDOC_VERSION

# create pandoc container by installing pandoc rpm and texlive
FROM fedora:33

LABEL maintainer="jwhb <jwhy@jwhy.de>"

RUN dnf install -y \
  make \
  findutils \
  texlive \
  texlive-babel-german \
  texlive-base \
  texlive-blindtext \
  texlive-german \
  texlive-latex \
  texlive-lipsum \
  texlive-morefloats \
  texlive-sectsty \
  texlive-siunitx \
  texlive-threeparttable \
  texlive-tocloft \
  texlive-truncate \
  texlive-ulem \
  texlive-wallpaper \
  && dnf clean all

# install pandoc from rpm
COPY --from=rpmbuild /tmp/rpmbuild/pandoc*.rpm /tmp/pandoc.rpm
RUN dnf localinstall -y /tmp/pandoc.rpm && rm -f /tmp/pandoc.rpm

WORKDIR /source

ENTRYPOINT []
