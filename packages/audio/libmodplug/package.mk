# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmodplug"
PKG_VERSION="0.8.9.2"
PKG_SHA256="e4d9cb46da78a639d6eadb4ff3ab955f68c3099579b5310af64b37091e28957e"
PKG_LICENSE="LicenseRef-PublicDomain"
PKG_SITE="http://modplug-xmms.sourceforge.net/"
PKG_URL="https://downloads.sourceforge.net/project/modplug-xmms/libmodplug/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libmodplug renders mod music files as raw audio data, for playing or conversion."
PKG_BUILD_FLAGS="+pic"
