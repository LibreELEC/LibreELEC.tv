# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.gambatte"
PKG_VERSION="0.5.0.74-Piers"
PKG_SHA256="4587cb916dea5f1d7ec3b3f4a52a751bd7ff1fa70a0c8ab811b93df6dcf80ee4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/kodi-game/game.libretro.gambatte"
PKG_URL="https://github.com/kodi-game/game.libretro.gambatte/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-gambatte"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.gambatte: Gambatte emulator for Kodi"
PKG_IS_ADDON="yes"

PKG_ADDON_TYPE="kodi.gameclient"
