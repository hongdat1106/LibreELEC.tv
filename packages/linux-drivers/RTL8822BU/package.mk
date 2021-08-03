# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8822BU"
PKG_VERSION="5.8.7.4"
PKG_SHA256="6f1d1ee8f130f0aee3271246a93f4e6c3143f9f56e9e3f64aba2c2415c2f26ca"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/morrownr/88x2bu"
PKG_URL="https://github.com/morrownr/88x2bu/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Realtek RTL8822BU Linux driver"
PKG_IS_KERNEL_PKG="yes"
PGK_TOOLCHAIN="manual"

################################################################################################
#template priority 1
pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=$TARGET_KERNEL_ARCH \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
#    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
     find $PKG_BUILD/ -name \*.ko -not -path '*/\.*' -exec cp {} $INSTALL/$(get_full_module_dir)/$PKG_NAME \;
}

################################################################################################
#template priority 2 for AMLOGIC
#pre_make_target() {
#  unset LDFLAGS
#}

#make_target() {
#  make  \
#    ARCH=$TARGET_KERNEL_ARCH \
#    KSRC=$(kernel_path) \
#    CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
#    USER_EXTRA_CFLAGS="-fgnu89-inline"
#}

#makeinstall_target() {
#  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
#    find $PKG_BUILD/ -name \*.ko -not -path '*/\.*' -exec cp {} $INSTALL/$(get_full_module_dir)/$PKG_NAME \;
#}

################################################################################################
#template priority 3
#make_target() {
#  kernel_make V=1 \
#       -C $(kernel_path) \
#       M="$PKG_BUILD/src"
#}

#makeinstall_target() {
# cd $PKG_BUILD
#  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
#    cp src/*.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
#}