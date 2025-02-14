# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="24.3.4"
PKG_SHA256="e641ae27191d387599219694560d221b7feaa91c900bcec46bf444218ed66025"
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
                     -Dvulkan-drivers="

PKG_MESON_OPTS_TARGET="-Dgallium-drivers=${GALLIUM_DRIVERS// /,} \
                       -Dgallium-extra-hud=false \
                       -Dgallium-rusticl=false \
                       -Dgallium-nine=false \
                       -Dgallium-opencl=disabled \
                       -Dshader-cache=enabled \
                       -Dshared-glapi=enabled \
                       -Dopencl-spirv=false \
                       -Dopengl=true \
                       -Dgbm=enabled \
                       -Degl=enabled \
                       -Dvalgrind=disabled \
                       -Dlibunwind=disabled \
                       -Dlmsensors=disabled \
                       -Dbuild-tests=false \
                       -Ddraw-use-llvm=false \
                       -Dmicrosoft-clc=disabled \
                       -Dosmesa=false"

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

if listcontains "${GRAPHIC_DRIVERS}" "iris"; then
  PKG_DEPENDS_TARGET+=" mesa:host"
  PKG_MESON_OPTS_TARGET+=" -Dintel-clc=system"
fi

if listcontains "${GRAPHIC_DRIVERS}" "(nvidia|nvidia-ng" ||
              [ "${OPENGL_SUPPORT}" = "yes" ] &&
              [ "${DISPLAYSERVER}" != "x11" ]; then
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
                           -Dvideo-codecs=vc1dec,h264dec,h264enc,h265dec,h265enc"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=disabled"
fi

if listcontains "${GRAPHIC_DRIVERS}" "vmware"; then
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=disabled"
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

makeinstall_host() {
  mkdir -p "${TOOLCHAIN}/bin"
    cp -a src/intel/compiler/intel_clc "${TOOLCHAIN}/bin"
}
