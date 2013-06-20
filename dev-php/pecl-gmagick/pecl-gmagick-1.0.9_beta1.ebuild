# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

PHP_EXT_NAME="gmagick"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

MY_PV="1.0.9b1"

inherit php-ext-pecl-r2

KEYWORDS="amd64 x86"

DESCRIPTION="PHP wrapper for the GraphicsMagick library."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples"

DEPEND=">=media-gfx/graphicsmagick-1.2.6"
RDEPEND="${DEPEND}"


src_configure() {
	my_conf="--with-gmagick=/usr"
	php-ext-source-r2_src_configure
}
