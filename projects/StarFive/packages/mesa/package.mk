# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

# StarFive Mesa for the JH7110: Mesa 22.1.3 with the patches from StarFive's
# buildroot (package/mesa3d, branch JH7110_VisionFive2_devel). Patch 0001 adds
# the pvr gallium driver, a thin DRI driver on top of Imagination's closed
# libpvr_dri_support.so (img-gpu-powervr); patch 0002 makes the loader pick it
# for the platform (non-PCI) display device.
#
# 0063/0064 are ours: build fixes for glibc >= 2.43 and Python >= 3.12.
#
# GBM + EGL + GLES only (DISPLAYSERVER=no), which is what Kodi uses.

PKG_NAME="mesa"
PKG_VERSION="22.1.3"
PKG_SHA256="b98f32ba7aa2a1ff5725fb36eb999c693079f0ca16f70aa2f103e2b6c3f093e3"
PKG_ARCH="riscv64"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/starfive-tech/buildroot/tree/JH7110_VisionFive2_devel/package/mesa3d"
PKG_URL="https://archive.mesa3d.org/older-versions/22.x/mesa-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain expat libdrm zlib Mako:host pyyaml:host img-gpu-powervr"
PKG_LONGDESC="Mesa with the PowerVR (pvr) gallium driver for the StarFive JH7110"

PKG_MESON_OPTS_TARGET="-Dgallium-drivers=pvr \
                       -Dvulkan-drivers= \
                       -Dplatforms= \
                       -Ddri3=disabled \
                       -Dglx=disabled \
                       -Degl=enabled \
                       -Dgbm=enabled \
                       -Dgles1=disabled \
                       -Dgles2=enabled \
                       -Dopengl=true \
                       -Dshared-glapi=enabled \
                       -Dglvnd=false \
                       -Dllvm=disabled \
                       -Dshader-cache=enabled \
                       -Dzstd=disabled \
                       -Dvalgrind=disabled \
                       -Dlibunwind=disabled \
                       -Dlmsensors=disabled \
                       -Dosmesa=false \
                       -Dgallium-vdpau=disabled \
                       -Dgallium-va=disabled \
                       -Dgallium-xa=disabled \
                       -Dgallium-xvmc=disabled \
                       -Dgallium-omx=disabled \
                       -Dgallium-nine=false \
                       -Dgallium-opencl=disabled \
                       -Dbuild-tests=false \
                       -Dmicrosoft-clc=disabled"

post_unpack() {
  # formats.csv has CRLF line endings, the buildroot patch for it has not
  sed -i 's/\r$//' ${PKG_BUILD}/src/mesa/main/formats.csv
}
