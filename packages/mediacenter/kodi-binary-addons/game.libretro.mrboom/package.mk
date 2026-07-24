# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mrboom"
PKG_VERSION="5.5.0.164-Omega"
PKG_SHA256="16e416e6063cd952974a6a1ca661239d655aca89d929ea4b1617d8408ded7760"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/kodi-game/game.libretro.mrboom"
PKG_URL="https://github.com/kodi-game/game.libretro.mrboom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-mrboom"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mrboom: mrboom for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
