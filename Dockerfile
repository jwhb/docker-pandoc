# build pandoc rpm with fpm
FROM ruby:alpine3.13 AS rpmbuild

ARG PANDOC_VERSION

# check if pandoc version is set
RUN test -n "$PANDOC_VERSION" || (echo "ERROR: PANDOC_VERSION not set" && exit 1)

# install fpm and build tools
RUN apk --no-cache add \
  make=4.3-r0 \
  gcc=10.2.1_pre1-r3 \
  libc-dev=0.7.2-r3 \
  wget=1.21.1-r1 \
  rpm=4.16.1.3-r0
RUN gem install fpm:1.11.0

# make rpm
WORKDIR /tmp/rpmbuild
COPY Makefile /tmp/rpmbuild
RUN make rpm PKG_VERSION=$PANDOC_VERSION

# create pandoc container by installing pandoc rpm and texlive
FROM fedora:35

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
COPY --from=rpmbuild /tmp/rpmbuild/pandoc*.rpm /root/pandoc.rpm
RUN dnf localinstall -y /root/pandoc.rpm && dnf clean all

WORKDIR /source

ENTRYPOINT []
