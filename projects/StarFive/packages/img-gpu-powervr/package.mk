# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

# Imagination PowerVR DDK userspace for the StarFive JH7110 (BXE-4-32,
# BVNC 36.50.54.182), prebuilt by StarFive (soft_3rdpart). It provides
# libpvr_dri_support.so, which the mesa pvr gallium driver dlopens, plus the
# closed GLES/Vulkan/OpenCL implementation behind it. The GPU firmware is
# built into the kernel (see packages/linux, LINUX=starfive).

PKG_NAME="img-gpu-powervr"
PKG_VERSION="1.19.6345021"
PKG_SHA256="9dcaf2084b13e59c4e50a4a288f5de56f8e9ee631627a3e818591675bf61311a"
PKG_ARCH="riscv64"
PKG_LICENSE="CLOSED"
PKG_SITE="https://github.com/starfive-tech/soft_3rdpart"
PKG_URL="https://github.com/starfive-tech/soft_3rdpart/raw/b60da16be1b36453aa46599889c28310fd148fb8/IMG_GPU/out/img-gpu-powervr-bin-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="img-gpu-powervr-bin-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_LONGDESC="Imagination PowerVR GPU userspace driver for the StarFive JH7110"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
  for lib in ${PKG_BUILD}/target/usr/lib/lib*.so*; do
    case "$(basename ${lib})" in
      # loaders/dispatch libraries come from mesa (EGL/GLES) or are not used
      libGLESv2.so*|libGLESv1_CM.so*|libvulkan*.so*|libOpenCL.so*)
        continue
        ;;
    esac
    cp -P ${lib} ${INSTALL}/usr/lib
  done

  # GPU debug tools (pvrdebug, pvrlogdump, ...)
  mkdir -p ${INSTALL}/usr/bin
    cp -P ${PKG_BUILD}/target/usr/local/bin/pvr* ${INSTALL}/usr/bin
}
