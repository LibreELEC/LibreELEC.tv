# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spirv-headers"
# The SPIRV-Headers pkg_version needs to match the compatible (known_good) glslang pkg_version.
# https://raw.githubusercontent.com/KhronosGroup/glslang/${PKG_VERSION}/known_good.json
# When updating glslang pkg_version please update to the known_good spirv-headers pkg_version.
# When updating spirv-llvm-translator pkg_version validate the minimum githash from
# https://github.com/KhronosGroup/SPIRV-LLVM-Translator/blob/main/spirv-headers-tag.conf
PKG_VERSION="1de2e410ae8b5f7276afcfd9f3401a1c4e2cb2d7"
PKG_SHA256="81cbbd1acf1595979d180e578be9146902b7a30580908aa939c3547c1cbe4148"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-headers"
PKG_URL="https://github.com/KhronosGroup/SPIRV-headers/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="SPIRV-Headers"
PKG_TOOLCHAIN="manual"
