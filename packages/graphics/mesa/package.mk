# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="26.3.0"
PKG_SHA256="91d729aa68bb89e4ec857841300bbe922bcb3e52b1f97566ca83930d3b28343a"
PKG_LICENSE="MIT"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://mesa.freedesktop.org/archive/mesa-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="toolchain:host expat:host libclc:host libdrm:host llvm:host Mako:host pyyaml:host spirv-tools:host"
PKG_DEPENDS_TARGET="toolchain expat libdrm Mako:host pyyaml:host"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."

# the prebuilt mesa:host tools published by mesa-reusable
PKG_REUSABLE_VERSION="${OS_VERSION}-${PKG_VERSION}"
PKG_REUSABLE_SOURCE_NAME="mesa-reusable-${PKG_REUSABLE_VERSION}-${MACHINE_HARDWARE_NAME}.tar"
PKG_REUSABLE_URL="https://github.com/LibreELEC/mesa-reusable/releases/download/${PKG_REUSABLE_VERSION}/${PKG_REUSABLE_SOURCE_NAME}"

get_graphicdrivers

if [ "${DEVICE}" = "Dragonboard" ]; then
  PKG_DEPENDS_TARGET+=" libarchive libxml2 lua54"
fi

# workaround: on 32-bit arm gcc emits a VFP literal pool load that is more than
# the 1020 byte vldr range away from its pool in the panfrost midgard compiler:
# {standard input}: Error: co-processor offset out of range
# dropping SLP vectorisation removes the 64-bit vector constants that overflow
# the pool. seen with gcc 16.2.0 and mesa 26.2.2 on RK3288.
if [ "${ARCH}" = "arm" ]; then
  TARGET_CFLAGS+=" -fno-tree-slp-vectorize"
fi

PKG_MESON_OPTS_HOST="-Dglvnd=disabled \
                     -Dgallium-drivers= \
                     -Dplatforms= \
                     -Dglx=disabled \
                     -Dvulkan-drivers=imagination \
                     -Dshared-llvm=disabled \
                     -Dtools=panfrost \
                     -Dvideo-codecs= \
                     -Dbuild-tests=false \
                     -Denable-glcpp-tests=false \
                     -Dmesa-clc=enabled \
                     -Dinstall-mesa-clc=true \
                     -Dprecomp-compiler=enabled \
                     -Dinstall-precomp-compiler=true \
                     -Dimagination-srv=false"

PKG_MESON_OPTS_TARGET="-Dgallium-drivers=${GALLIUM_DRIVERS// /,} \
                       -Dgallium-extra-hud=false \
                       -Dgallium-rusticl=false \
                       -Dshader-cache=enabled \
                       -Dopengl=true \
                       -Dgbm=enabled \
                       -Degl=enabled \
                       -Dvalgrind=disabled \
                       -Dlibunwind=disabled \
                       -Dlmsensors=disabled \
                       -Dbuild-tests=false \
                       -Dmicrosoft-clc=disabled"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence libXrandr"
  export X11_INCLUDES=
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=x11 \
                           -Dglx=dri"
elif [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=wayland \
                           -Dglx=disabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dplatforms="" \
                           -Dglx=disabled"
fi

if listcontains "${GRAPHIC_DRIVERS}" "etnaviv"; then
  PKG_DEPENDS_TARGET+=" pycparser:host"
fi

if listcontains "${GRAPHIC_DRIVERS}" "(i915|r300)"; then
  PKG_MESON_OPTS_TARGET+=" -Ddraw-use-llvm=true"
else
  PKG_MESON_OPTS_TARGET+=" -Ddraw-use-llvm=false"
fi

if listcontains "${GRAPHIC_DRIVERS}" "imagination"; then
  PKG_DEPENDS_TARGET+=" spirv-tools"
  PKG_MESON_OPTS_TARGET+=" -Dimagination-srv=true"
fi

if listcontains "${GRAPHIC_DRIVERS}" "(imagination|iris|panfrost)"; then
  # preferred falls back to building mesa:host when no reusable archive is available
  if [ "${USE_REUSABLE}" = "yes" ] ||
     { [ "${USE_REUSABLE}" = "preferred" ] &&
       [ -n "$(get_reusable_sha256 mesa-reusable ${PKG_REUSABLE_SOURCE_NAME} ${PKG_REUSABLE_URL})" ]; }; then
    PKG_DEPENDS_TARGET+=" mesa-reusable"
  else
    PKG_DEPENDS_TARGET+=" mesa:host"
  fi
  PKG_MESON_OPTS_TARGET+=" -Dmesa-clc=system -Dprecomp-compiler=system"
fi

if listcontains "${GRAPHIC_DRIVERS}" "(nvidia|nvidia-ng)" ||
              [ "${OPENGL_SUPPORT}" = "yes" -a "${DISPLAYSERVER}" != "x11" ]; then
  PKG_DEPENDS_TARGET+=" libglvnd"
  PKG_MESON_OPTS_TARGET+=" -Dglvnd=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dglvnd=disabled"
fi

if [ "${LLVM_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" elfutils llvm"
  PKG_MESON_OPTS_TARGET+=" -Dllvm=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dllvm=disabled"
fi

if [ "${VAAPI_SUPPORT}" = "yes" ] && listcontains "${GRAPHIC_DRIVERS}" "(r600|radeonsi)"; then
  PKG_DEPENDS_TARGET+=" libva"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=enabled \
                           -Dvideo-codecs=mpeg12dec,vc1dec,h264dec,h264enc,h265dec,h265enc,av1dec,av1enc,vp9dec"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=disabled"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_MESON_OPTS_TARGET+=" -Dgles1=disabled -Dgles2=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dgles1=disabled -Dgles2=disabled"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN} vulkan-tools ply:host"
  PKG_MESON_OPTS_TARGET+=" -Dvulkan-drivers=${VULKAN_DRIVERS_MESA// /,}"
else
  PKG_MESON_OPTS_TARGET+=" -Dvulkan-drivers="
fi

pre_configure_host() {
  local msg="mesa-reusable ${PKG_REUSABLE_VERSION} is not available for ${MACHINE_HARDWARE_NAME}"

  # say why mesa:host is being built when a reusable archive was preferred
  if [ "${USE_REUSABLE}" = "preferred" ] &&
     [ -z "$(get_reusable_sha256 mesa-reusable ${PKG_REUSABLE_SOURCE_NAME} ${PKG_REUSABLE_URL})" ]; then
    build_msg "CLR_WARNING" "WARNING" "${msg}, building mesa:host"
  fi
}

makeinstall_host() {
  host_files="src/compiler/clc/mesa_clc \
              src/compiler/spirv/vtn_bindgen2 \
              src/imagination/pco/uscgen/pco_clc \
              src/panfrost/clc/panfrost_compile"

  if listcontains "${BUILD_REUSABLE}" "(all|mesa:host)"; then
    # Build the reusable mesa:host for both local and to be added to a GitHub release
    strip ${host_files}
    upx --lzma ${host_files}

    REUSABLE_SOURCES="${SOURCES}/mesa-reusable"
    REUSABLE_SOURCE_NAME="${PKG_REUSABLE_SOURCE_NAME}"

    mkdir -p "${TARGET_IMG}"

    tar cf ${TARGET_IMG}/${REUSABLE_SOURCE_NAME} --transform='s|.*/||' ${host_files}
    sha256sum ${TARGET_IMG}/${REUSABLE_SOURCE_NAME} | \
      cut -d" " -f1 >${TARGET_IMG}/${REUSABLE_SOURCE_NAME}.sha256

    if listcontains "${BUILD_REUSABLE}" "save-local"; then
      mkdir -p "${REUSABLE_SOURCES}"
      cp -p ${TARGET_IMG}/${REUSABLE_SOURCE_NAME} ${REUSABLE_SOURCES}
      cp -p ${TARGET_IMG}/${REUSABLE_SOURCE_NAME}.sha256 ${REUSABLE_SOURCES}
      echo "save-local" >${REUSABLE_SOURCES}/${REUSABLE_SOURCE_NAME}.url
    fi
  fi

  mkdir -p "${TOOLCHAIN}/bin"
    cp -a ${host_files} "${TOOLCHAIN}/bin"
}
