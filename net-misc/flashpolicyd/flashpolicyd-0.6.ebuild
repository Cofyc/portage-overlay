EAPI="4"

inherit eutils git-2

DESCRIPTION="Setting up a socket policy file server"
HOMEPAGE="http://www.adobe.com/devnet/flashplayer/articles/socket_policy_files.html"

EGIT_REPO_URI="https://github.com/Cofyc/flashpolicyd"
EGIT_COMMIT="master"
EGIT_PROJECT="flashpolicyd-${PV}"
SLOT="0"
KEYWORDS="amd64 x86 x86-macos x86-solaris"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup flashpolicyd
	enewuser flashpolicyd -1 -1 /var/empty flashpolicyd
}

src_compile() {
	einfo "Nothing to compile, passed"
}

src_install() {
	dobin flashpolicyd.py
	insinto /etc/
	doins flashpolicy.xml
	fowners flashpolicyd:flashpolicyd /etc/flashpolicy.xml

	newinitd "${FILESDIR}/initd" flashpolicyd
}
