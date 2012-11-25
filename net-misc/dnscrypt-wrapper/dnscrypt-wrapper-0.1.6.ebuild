EAPI="4"

inherit eutils flag-o-matic

DESCRIPTION="This is dnscrypt wrapper (server-side dnscrypt proxy), which helps to add dnscrypt support to any name resolver."
HOMEPAGE="https://github.com/Cofyc/dnscrypt-wrapper"
SRC_URI="https://github.com/Cofyc/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser dnscrypt-wrapper -1 -1 /var/empty daemon
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "compile failed"
}

src_install() {
	dobin dnscrypt-wrapper

	newconfd "${FILESDIR}/conf" dnscrypt-wrapper
	newinitd "${FILESDIR}/init" dnscrypt-wrapper
}
