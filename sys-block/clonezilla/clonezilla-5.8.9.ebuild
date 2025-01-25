# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Clonezilla is a partition and disk imaging/cloning program"
HOMEPAGE="https://clonezilla.org"
SRC_URI="https://github.com/stevenshiau/clonezilla/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-apps/file
	sys-block/parted
	sys-boot/drbl
	sys-apps/gptfdisk
	net-misc/wget
	sys-block/partclone
	sys-block/partimage
	sys-fs/ntfs3g[ntfsprogs]
	net-misc/udpcast
	sys-apps/smartmontools
	app-text/html2text
	app-arch/pigz
	app-arch/zstd
	sys-libs/ncurses
"
RDEPEND="${DEPEND}"
BDEPEND=""