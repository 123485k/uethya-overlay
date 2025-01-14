# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Kernel module for keyboard backlighting for Clevo laptops"
HOMEPAGE="https://github.com/wessel-novacustom/clevo-keyboard"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/wessel-novacustom/clevo-keyboard.git"
	inherit git-r3
	unset MODULES_KERNEL_MAX
else
	SRC_URI="https://github.com/wessel-novacustom/clevo-keyboard/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="HWMON PCI AMD_NB"
MODULES_KERNEL_MIN=5.3.4

src_compile() {
	local modlist=(
		tuxedo_keyboard
		clevo_wmi
		clevo_acpi
		tuxedo_io
		uniwill_wmi
	)
	local modargs=( TARGET="${KV_FULL}" KERNEL_BUILD="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
	# copy kernel modules to the right place
	local kofilelist=(
		tuxedo_keyboard
		clevo_wmi
		clevo_acpi
		uniwill_wmi
		tuxedo_io/tuxedo_io
		)
	for mod in "${kofilelist[@]}"; do
		if [[ -f "${S}/src/${mod}.ko" ]]; then
		    cp "${S}/src/${mod}.ko" "${S}" || die
		fi
	done
}

src_install() {
	linux-mod-r1_src_install
}
