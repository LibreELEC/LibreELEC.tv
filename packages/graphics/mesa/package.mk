# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="25.2.2"
PKG_SHA256="43d7abcd4aa8049d8fd75538344a374104765e81e17b4a6314cee2c0160e4412"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://mesa.freedesktop.org/archive/mesa-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="toolchain:host expat:host libclc:host libdrm:host Mako:host pyyaml:host spirv-tools:host"
PKG_DEPENDS_TARGET="toolchain expat libdrm Mako:host pyyaml:host"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."

get_graphicdrivers

if [ "${DEVICE}" = "Dragonboard" ]; then
  PKG_DEPENDS_TARGET+=" libarchive libxml2 lua54"
fi

PKG_MESON_OPTS_HOST="-Dglvnd=disabled \
                     -Dgallium-drivers=iris \
                     -Dgallium-vdpau=disabled \
                     -Dplatforms= \
                     -Dglx=disabled \
                     -Dvulkan-drivers= \
                     -Dshared-llvm=disabled \
                     -Dtools=panfrost"

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
                       -Ddraw-use-llvm=false \
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

if listcontains "${GRAPHIC_DRIVERS}" "(iris|panfrost)"; then
  if [ "${USE_REUSABLE}" = "yes" ]; then
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

if [ "${VDPAU_SUPPORT}" = "yes" -a "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libvdpau"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=disabled"
fi

if [ "${VAAPI_SUPPORT}" = "yes" ] && listcontains "${GRAPHIC_DRIVERS}" "(r600|radeonsi)"; then
  PKG_DEPENDS_TARGET+=" libva"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=enabled \
                           -Dvideo-codecs=vc1dec,h264dec,h264enc,h265dec,h265enc,av1dec,av1enc,vp9dec"
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
  if listcontains "${VULKAN_DRIVERS_MESA}" "nouveau"; then
    PKG_DEPENDS_TARGET+=" rust:host bindgen-cli:host cbindgen:host"
  fi
  PKG_MESON_OPTS_TARGET+=" -Dvulkan-drivers=${VULKAN_DRIVERS_MESA// /,}"
else
  PKG_MESON_OPTS_TARGET+=" -Dvulkan-drivers="
fi

makeinstall_host() {
  host_files="src/compiler/clc/mesa_clc src/compiler/spirv/vtn_bindgen2 src/panfrost/clc/panfrost_compile"

  if listcontains "${BUILD_REUSABLE}" "(all|mesa:host)"; then
    # Build the reusable mesa:host for both local and to be added to a GitHub release
    strip ${host_files}
    upx --lzma ${host_files}

    REUSABLE_SOURCES="${SOURCES}/mesa-reusable"
    MESA_HOST="mesa-reusable-${OS_VERSION}-${PKG_VERSION}"
    REUSABLE_SOURCE_NAME=${MESA_HOST}-${MACHINE_HARDWARE_NAME}.tar

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
