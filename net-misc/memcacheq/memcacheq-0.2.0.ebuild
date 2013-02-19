# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils autotools flag-o-matic

MY_PV="${PV/_rc/-rc}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Simple Queue Service over Memcache"
HOMEPAGE="http://code.google.com/p/memcacheq/"
SRC_URI="http://memcacheq.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 x86-macos x86-solaris"

RDEPEND=">=dev-libs/libevent-1.4
		 >=sys-libs/db-4.7"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

MEMCACHEQ_DATAPATH=/var/lib/memcacheq

pkg_setup() {
	enewgroup memcacheq || die "problem adding 'memcacheq' group"
	enewuser memcacheq -1 -1 /dev/null memcacheq || die "problem adding 'memcacheq' user"
}

src_configure() {
	econf \
		--prefix=/usr || die "econf failed."
}

src_compile() {
	emake all || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodir /var/lib/memcacheq /var/run/memcacheq
	fowners memcacheq:memcacheq \
		/var/lib/memcacheq \
		/var/run/memcacheq

	newconfd "${FILESDIR}"/conf memcacheq
	newinitd "${FILESDIR}"/init memcacheq
}

pkg_postinst() {
	einfo "Notice: Because MemcacheQ is using fixed-length storage, so you "
	einfo "should use '-B' option to specify the max length of your message."
	einfo "Default is 1024 bytes."
}
