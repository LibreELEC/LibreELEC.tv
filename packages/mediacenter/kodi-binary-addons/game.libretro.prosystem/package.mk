# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.prosystem"
PKG_VERSION="1.3.0.46-Omega"
PKG_SHA256="e537414057bc6d3a670d472e6273abc1bd393ac94e38be0d621f91cebbeb4cbb"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/kodi-game/game.libretro.prosystem"
PKG_URL="https://github.com/kodi-game/game.libretro.prosystem/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml ${MEDIACENTER}:host libretro-prosystem"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.prosystem: Prosystem for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
