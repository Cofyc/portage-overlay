EAPI=4

inherit autotools-utils eutils git-2

DESCRIPTION="A IRC server written from scratch (A personal modified ngircd)"
HOMEPAGE="https://github.com/Cofyc/ngircd"
EGIT_REPO_URI="https://github.com/Cofyc/ngircd"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 x64-macos"
IUSE="debug gnutls ident ipv6 pam ssl tcpd zlib verycd"

if use verycd; then
	EGIT_BRANCH="verycd"
else
	EGIT_COMMIT="rel-20.2"
fi

RDEPEND="
	ident? ( net-libs/libident )
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl )
	)
	pam? ( virtual/pam )
	tcpd? ( sys-apps/tcp-wrappers )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
"

RESTRICT="test"

src_configure() {
	if ! use prefix; then
		sed -i \
			-e "s:;ServerUID = 65534:ServerUID = ngircd:" \
			-e "s:;ServerGID = 65534:ServerGID = nogroup:" \
			doc/sample-ngircd.conf.tmpl || die
	fi

	local myeconfargs=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--sysconfdir="${EPREFIX}"/etc/ngircd
		$(use_enable ipv6)
		$(use_with zlib)
		$(use_with tcpd tcp-wrappers)
		$(use_with ident)
		$(use_with pam)
		$(use_enable debug)
		$(use_enable debug sniffer)
	)

	if use ssl; then
		myeconfargs+=(
			$(use_with !gnutls openssl)
			$(use_with gnutls)
		)
	else
		myeconfargs+=(
			--without-gnutls
			--without-ssl
		)
	fi

	./autogen.sh
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	newinitd "${FILESDIR}"/ngircd.init.d ngircd
}

pkg_postinst() {
	if ! use prefix; then
		enewuser ngircd
		chown ngircd "${ROOT}"/etc/ngircd/ngircd.conf
	fi
}
