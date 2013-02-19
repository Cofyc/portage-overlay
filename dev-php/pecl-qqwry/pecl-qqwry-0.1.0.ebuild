# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

PHP_EXT_NAME="qqwry"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
USE_PHP="php5-3 php5-4"
DOCS="TODO"

MY_PV="0.1.0"

inherit php-ext-pecl-r2

KEYWORDS="amd64 x86"

DESCRIPTION="PHP QQWry."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples"



src_configure() {
	#my_conf="--with-gmagick=/usr"
	php-ext-source-r2_src_configure
}
