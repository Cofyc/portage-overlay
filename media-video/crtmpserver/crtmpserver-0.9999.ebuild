EAPI=4
inherit cmake-utils
inherit eutils git-2

DESCRIPTION="C++ RTMP Server"
HOMEPAGE="http://www.rtmpd.com/"
EGIT_REPO_URI="https://github.com/Cofyc/crtmpserver"
EGIT_BRANCH="1.0"
EGIT_PROJECT="crtmpserver-${PV}"
LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

MAKEOPTS=-j1
CMAKE_USE_DIR="${WORKDIR}/${PF}/builders/cmake"
CMAKE_BUILD_TYPE="Release"
MYCMAKEARGS="-DCRTMPSERVER_INSTALL_PREFIX=${EPREFIX}${PREFIX:-/usr}
-DTEMP_FRAMEWORK_VER=${PV}"

CRTMPSERVER_DIR=/usr/lib/crtmpserver/

pkg_setup() {
	enewgroup crtmpserver
	enewuser crtmpserver -1 -1 ${CRTMPSERVER_DIR} crtmpserver
}

src_install() {
	cmake-utils_src_install

	keepdir /var/run/crtmpserver
	fowners crtmpserver:crtmpserver /var/run/crtmpserver
	keepdir /etc/crtmpserver
	fowners crtmpserver:crtmpserver /etc/crtmpserver
	insinto /etc/crtmpserver
	sed -i -r \
		-e '/rootDirectory="applications",/s,applications,/usr/lib/crtmpserver/applications,' \
		"${WORKDIR}/${PF}/builders/cmake/crtmpserver/crtmpserver.lua"
	doins "${WORKDIR}/${PF}/builders/cmake/crtmpserver/crtmpserver.lua"
	fowners crtmpserver:crtmpserver /etc/crtmpserver/crtmpserver.lua

	newinitd "${FILESDIR}/initd" crtmpserver
	newconfd "${FILESDIR}/confd" crtmpserver

	doman man/crtmpserver.1
}
