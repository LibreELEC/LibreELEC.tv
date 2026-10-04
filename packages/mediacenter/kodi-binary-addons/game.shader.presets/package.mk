# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.shader.presets"
PKG_VERSION="22.1.4-Piers"
PKG_SHA256="2ed1f319ab7a369e929788c24312d0fa8c9570f75a5752196c318a71a34ec567"
PKG_REV="5"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.shader.presets"
PKG_URL="https://github.com/kodi-game/game.shader.presets/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host"
PKG_SECTION=""
PKG_SHORTDESC="game.shader.presets: Shader preset support"
PKG_LONGDESC="game.shader.presets adds libretro meta shader preset support"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.shader.presets"
