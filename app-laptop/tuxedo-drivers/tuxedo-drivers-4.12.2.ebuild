# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# shellcheck disable=SC2148

# shellcheck disable=SC2034
EAPI=8

inherit linux-mod-r1

DESCRIPTION="Kernel module for keyboard backlighting for Clevo laptops"
HOMEPAGE="https://github.com/wessel-novacustom/clevo-keyboard"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/tuxedocomputers/tuxedo-drivers.git"
	inherit git-r3
	unset MODULES_KERNEL_MAX
else
	SRC_URI="https://github.com/tuxedocomputers/tuxedo-drivers/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

PATCHES=(
	"${FILESDIR}/${P}-disable-compat-check.patch"
)

LICENSE="GPL-2"
SLOT="0"
MODULES_KERNEL_MIN=5.3.4

S="${WORKDIR}/${P}"
src_compile() {
	local modlist=(
		tuxedo_compatibility_check=tuxedo::src/tuxedo_compatibility_check
		tuxedo_keyboard=tuxedo::src
		clevo_acpi=tuxedo::src
		clevo_wmi=tuxedo::src
		uniwill_wmi=tuxedo::src
		tuxedo_io=tuxedo::src/tuxedo_io
		ite_8291=tuxedo::src/ite_8291
		ite_8291_lb=tuxedo::src/ite_8291_lb
		ite_8297=tuxedo::src/ite_8297
		ite_829x=tuxedo::src/ite_829x
		stk8321=tuxedo::src/stk8321
		tuxedo_nb05_ec=tuxedo::src/tuxedo_nb05
		tuxedo_nb05_power_profiles=tuxedo::src/tuxedo_nb05
		tuxedo_nb05_sensors=tuxedo::src/tuxedo_nb05
		tuxedo_nb05_keyboard=tuxedo::src/tuxedo_nb05
		tuxedo_nb04_keyboard=tuxedo::src/tuxedo_nb04
		tuxedo_nb04_wmi_ab=tuxedo::src/tuxedo_nb04
		tuxedo_nb04_wmi_bs=tuxedo::src/tuxedo_nb04
		tuxedo_nb04_sensors=tuxedo::src/tuxedo_nb04
		tuxedo_nb04_power_profiles=tuxedo::src/tuxedo_nb04
		tuxedo_nb04_kbd_backlight=tuxedo::src/tuxedo_nb04
	)
	local modargs=( TARGET="${KV_FULL}" KERNEL_BUILD="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
}