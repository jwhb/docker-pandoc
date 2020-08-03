FPM=fpm
PANDOC_TAR_URL=https://github.com/jgm/pandoc/releases/download/${PKG_VERSION}/pandoc-${PKG_VERSION}-linux-amd64.tar.gz
PANDOC_TAR_NAME=pandoc.tar.gz
TMPINSTALLDIR=/tmp/$(PKG_NAME)-fpm-install

PKG_NAME=pandoc
PKG_DESCRIPTION="Pandoc Document Converter"
PKG_VERSION=2.5
PKG_RELEASE=0
PKG_MAINTAINER="Jasper Wiegratz <wiegratz@uni-bremen.de>"
PKG_ARCH=x86_64
PKG_ARCH_RPM=${PKG_ARCH}
PKG_RPM=${PKG_NAME}-${PKG_VERSION}-${PKG_RELEASE}.${PKG_ARCH_RPM}.rpm

TAR_OPTS=--strip-components=1
FPM_OPTS=-s dir -n $(PKG_NAME) -v $(PKG_VERSION) --iteration $(PKG_RELEASE) --maintainer ${PKG_MAINTAINER} --description $(PKG_DESCRIPTION) -a $(PKG_ARCH) \
	 $(TMPINSTALLDIR)/.=/usr

all:	rpm

tmpdir:
	rm -rf $(TMPINSTALLDIR)
	rm -rf $(PKG_RPM)
	mkdir -p $(TMPINSTALLDIR)

pandoc.tar.gz:
	wget -nv -O $(PANDOC_TAR_NAME) $(PANDOC_TAR_URL)

pandoc-src: pandoc.tar.gz tmpdir
	tar -xzf $(PANDOC_TAR_NAME) -C $(TMPINSTALLDIR) $(TAR_OPTS)

rpm: pandoc-src
	rm -f $(PKG_RPM)
	chmod -R g-w *	
	$(FPM) -t rpm -p $(PKG_RPM) $(FPM_OPTS)

clean:
	rm -f $(PKG_RPM) $(PANDOC_TAR_NAME)
	rm -rf $(TMPINSTALLDIR)
