# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyperion"
PKG_VERSION="fb413cd7e8825ffc26925013f57ac93a774f12bc"
PKG_SHA256="fafa4eeddacb15a8fd96b0e69fac400faa735c6e1ccd78673c9d96b0ac84d7a3"
PKG_VERSION_DATE="2019-08-19"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/hyperion-project/hyperion"
PKG_URL="https://github.com/hyperion-project/hyperion/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 libusb qt5 protobuf rpi_ws281x"
PKG_DEPENDS_UNPACK="rpi_ws281x"
PKG_SECTION="service"
PKG_SHORTDESC="Hyperion: an AmbiLight controller"
PKG_LONGDESC="Hyperion(${PKG_VERSION_DATE}) is an modern opensource AmbiLight implementation."
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Hyperion"
PKG_ADDON_TYPE="xbmc.service"

PKG_DISPMANX_SUPPORT="-DENABLE_DISPMANX=OFF"
PKG_FB_SUPPORT="-DENABLE_FB=ON"
PKG_X11_SUPPORT="-DENABLE_X11=OFF"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" xorg-server xrandr"
  PKG_X11_SUPPORT="-DENABLE_X11=ON"
fi

PKG_CMAKE_OPTS_TARGET="-DCMAKE_NO_SYSTEM_FROM_IMPORTED=ON \
                       -DHYPERION_VERSION_ID="${PKG_VERSION}" \
                       -DENABLE_AMLOGIC=OFF \
                       ${PKG_DISPMANX_SUPPORT} \
                       ${PKG_FB_SUPPORT} \
                       -DENABLE_OSX=OFF \
                       -DUSE_SYSTEM_PROTO_LIBS=ON \
                       -DENABLE_SPIDEV=ON \
                       -DENABLE_TINKERFORGE=OFF \
                       -DENABLE_V4L2=ON \
                       -DENABLE_WS2812BPWM=OFF \
                       -DENABLE_WS281XPWM=ON \
                       ${PKG_X11_SUPPORT} \
                       -DENABLE_QT5=ON \
                       -DENABLE_TESTS=OFF \
                       -Wno-dev"

pre_build_target() {
  cp -a $(get_build_dir rpi_ws281x)/* ${PKG_BUILD}/dependencies/external/rpi_ws281x
}

pre_configure_target() {
  echo "" > ../cmake/FindGitVersion.cmake
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp ${PKG_INSTALL}/usr/bin/* ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  cp -PR ${PKG_INSTALL}/usr/share/hyperion/webconfig ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -PR ${PKG_INSTALL}/usr/share/hyperion/effects ${ADDON_BUILD}/${PKG_ADDON_ID}
}
