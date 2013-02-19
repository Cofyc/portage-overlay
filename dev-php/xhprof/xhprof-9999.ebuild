EAPI="4"

PHP_EXT_NAME="xhprof"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
USE_PHP="php5-3 php5-4"
PHP_EXT_S="${WORKDIR}/xhprof-${PV}/extension"

inherit php-ext-pecl-r2 git-2

HOMEPAGE="https://github.com/facebook/xhprof/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/facebook/xhprof.git"
DESCRIPTION="A Hierarchical Profiler for PHP"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="php_targets_php5-3 php_targets_php5-4"
KEYWORDS="amd64 x86"

src_unpack() {
	git-2_src_unpack "$@"
	local slot orig_s="${PHP_EXT_S}"
	for slot in $(php_get_slots); do
		cp -r "${orig_s}" "${WORKDIR}/${slot}" || die "Failed to copy source ${orig_s} to PHP target directory"
	done
}

