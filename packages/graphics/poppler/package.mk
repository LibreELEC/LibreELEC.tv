# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="poppler"
PKG_VERSION="26.01.0"
PKG_SHA256="1cb944a4b88847f5fb6551683bc799db59f04990f5d8be07aba2acbf38601089"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://poppler.freedesktop.org"
PKG_URL="https://poppler.freedesktop.org/poppler-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib freetype fontconfig libjpeg-turbo libpng openjpeg"
PKG_LONGDESC="A PDF rendering library, used by vfs.pdf to display game manuals."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

# Only the PDF parsing and rasterising is wanted. The cpp frontend is the one
# vfs.pdf uses; everything else is switched off, both to keep the library small
# and because each backend that is not built is one less piece of attack
# surface for a format that arrives from outside Kodi.
#
# OpenJPEG is needed because scanned manuals mostly store their pages as
# JPEG 2000, which otherwise render blank. Colour management stays off, so the
# add-on needs no library the image lacks.
# Poppler hides its symbols and its inline functions, which suits a shared
# library. This is a static archive linked into an add-on, and the linker then
# refuses the inlined std::string members it emitted as hidden, so the
# visibility defaults are put back.
PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_GTK_TESTS=OFF \
                       -DBUILD_QT5_TESTS=OFF \
                       -DBUILD_QT6_TESTS=OFF \
                       -DBUILD_CPP_TESTS=OFF \
                       -DBUILD_MANUAL_TESTS=OFF \
                       -DENABLE_CPP=ON \
                       -DENABLE_UTILS=OFF \
                       -DENABLE_GLIB=OFF \
                       -DENABLE_QT5=OFF \
                       -DENABLE_QT6=OFF \
                       -DENABLE_NSS3=OFF \
                       -DENABLE_GPGME=OFF \
                       -DENABLE_LIBCURL=OFF \
                       -DENABLE_BOOST=OFF \
                       -DENABLE_LIBOPENJPEG=openjpeg2 \
                       -DENABLE_LIBTIFF=OFF \
                       -DENABLE_LCMS=OFF \
                       -DWITH_Cairo=OFF \
                       -DWITH_NSS3=OFF \
                       -DRUN_GPERF_IF_PRESENT=OFF \
                       -DCMAKE_C_VISIBILITY_PRESET=default \
                       -DCMAKE_CXX_VISIBILITY_PRESET=default \
                       -DCMAKE_VISIBILITY_INLINES_HIDDEN=OFF"
