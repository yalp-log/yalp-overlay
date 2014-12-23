# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=(python2_7)

inherit eutils distutils-r1


DESCRIPTION="Distributed log parsing and collection"
HOMEPAGE="https://github.com/yalp-log/yalp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mongodb"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/celery[${PYTHON_USEDEP}]
	mongodb? ( dev-python/pymongo[${PYTHON_USEDEP}] )"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}"

DOCS=(README.rst)


python_install_all() {
	USE_SETUPTOOLS=1 disutils-r1_python_install_all

	for s in inputs outputers parsers; do
		newinitd "${FILESDIR}"/${s}-initd yalp-${s}
		newconfd "${FILESDIR}"/${s}-confd yalp-${s}
	done

	insinto /etc/${PN}
	doins -r conf/*
}
