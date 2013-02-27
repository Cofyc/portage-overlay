EAPI="4"

inherit base

DESCRIPTION="Network traffic statics utility for Solaris and Linux"
HOMEPAGE="http://iperf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 x86 x86-macos x86-solaris"

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	make -f Makefile.Linux
}

src_install() {
	mv `./nicstat.sh --bin-name` nicstat
	dobin nicstat
	dobin enicstat
	doman nicstat.1
}
