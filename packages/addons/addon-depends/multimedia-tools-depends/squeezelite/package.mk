# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="squeezelite"
PKG_VERSION="279ac086053239323f5c4df965342e3be5d10671"
PKG_SHA256="ff5fb3e7896e5f537b1ff0789162bbac45a76961dd93d4896d26726fef9c72e7"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/ralph-irving/squeezelite"
PKG_URL="https://github.com/ralph-irving/squeezelite/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain faad2 ffmpeg flac libmad libvorbis mpg123 soxr libogg"
PKG_DEPENDS_CONFIG="mpg123"
PKG_LONGDESC="A client for the Lyrion Music Server."
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  make \
    OPTS="-DDSD -DFFMPEG -DRESAMPLE -DVISEXPORT -DLINKALL" \
    CFLAGS="${CFLAGS} $(pkg-config --cflags libmpg123 vorbisfile vorbis ogg)" \
    LDFLAGS+=" $(pkg-config --libs libmpg123 vorbisfile vorbis ogg)"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p squeezelite ${INSTALL}/usr/bin
}
