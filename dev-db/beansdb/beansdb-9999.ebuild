EAPI=4

inherit autotools-utils eutils git-2

DESCRIPTION="Yet anonther distributed key-value storage system from Douban Inc."
HOMEPAGE="https://github.com/douban/beansdb/"
EGIT_REPO_URI="https://github.com/douban/beansdb/"
EGIT_BRANCH="master"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup beansdb
	enewuser beansdb -1 -1 /var/empty beansdb
}

src_configure() {
	./autogen.sh
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	newconfd "${FILESDIR}/conf" beansdb
	newinitd "${FILESDIR}/init" beansdb

	keepdir /var/lib/beansdb
	fowners beansdb:beansdb /var/lib/beansdb
}
