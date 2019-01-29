# build pandoc rpm with fpm
FROM ruby:alpine AS rpmbuild

ARG PANDOC_VERSION

# check if pandoc version is set
RUN test -n "$PANDOC_VERSION" || (echo "ERROR: PANDOC_VERSION not set" && exit 1)

# install fpm and build tools
RUN apk --no-cache add make gcc libc-dev wget rpm
RUN gem install fpm

# make rpm
WORKDIR /tmp/rpmbuild
COPY Makefile /tmp/rpmbuild
RUN make rpm PKG_VERSION=$PANDOC_VERSION

# create pandoc container by installing pandoc rpm and texlive
FROM fedora

MAINTAINER wiegratz <wiegratz@uni-bremen.de>

RUN dnf install -y \
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
