# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ffmpeg"
PKG_VERSION="9.0"
PKG_SHA256="7f607a00dd0d28a729d5a4811205812eef01cf6ef6155025febb6f36a9062d52"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://ffmpeg.org"
PKG_URL="http://ffmpeg.org/releases/ffmpeg-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib bzip2 openssl speex libxml2"
PKG_LONGDESC="FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video."
PKG_PATCH_DIRS="postproc libreelec"
PKG_NO_REFRESH_PATCHES="tools/ffmpeg/gen-patches.sh"

PKG_FFMPEG_REQUEST_DISABLE="--disable-libudev --disable-v4l2-request"
PKG_FFMPEG_REQUEST_ENABLE="--enable-libudev --enable-v4l2-request"

case "${PROJECT}" in
  Amlogic)
    PKG_VERSION="3a4c4864e5790539ef00eeef8a229dbf19dc62e0"
    PKG_FFMPEG_BRANCH="test/8.1.1/main"
    PKG_SHA256="c1755a73a4ac9a004bbdcb1cbf6b75308de7a9e918cdf8630d6e50ff25b4e0ed"
    PKG_URL="https://github.com/jc-kynesim/rpi-ffmpeg/archive/${PKG_VERSION}.tar.gz"
    ;;
  Generic)
    PKG_FFMPEG_REQUEST_DISABLE=""
    PKG_FFMPEG_REQUEST_ENABLE=""
    ;;
  Rockchip)
    case "${DEVICE}" in
      RK3288|RK3328|RK3399)
        PKG_PATCH_DIRS+=" v4l2-request v4l2-drmprime vf-deinterlace-v4l2m2m"
        ;;
      RK356X|RK3576|RK3588)
        PKG_PATCH_DIRS+=" v4l2-request detlev v4l2-drmprime vf-deinterlace-v4l2m2m"
        ;;
    esac
    ;;
  RPi)
    PKG_FFMPEG_RPI="--disable-mmal --enable-sand"
    PKG_PATCH_DIRS+=" rpi"
    ;;
  *)
    PKG_PATCH_DIRS+=" v4l2-request v4l2-drmprime"
    case "${PROJECT}" in
      Allwinner | Rockchip)
        PKG_PATCH_DIRS+=" vf-deinterlace-v4l2m2m"
        ;;
    esac
    ;;
esac

post_unpack() {
  # Fix FFmpeg version
  if [ "${PROJECT}" = "Amlogic" ] || [ "${PROJECT}" = "Rockchip" ]; then
    echo "${PKG_FFMPEG_BRANCH}-${PKG_VERSION:0:7}" >${PKG_BUILD}/VERSION
  else
    echo "${PKG_VERSION}" >${PKG_BUILD}/RELEASE
  fi
}

# Dependencies
get_graphicdrivers

PKG_FFMPEG_HWACCEL="--enable-hwaccels"

if [ "${V4L2_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" libdrm"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libdrm)"
  PKG_FFMPEG_V4L2="--enable-v4l2_m2m --enable-libdrm"

  if [ "${PROJECT}" = "Allwinner" -o "${PROJECT}" = "Rockchip" -o "${DEVICE}" = "iMX8" -o "${DEVICE}" = "RPi4" -o "${DEVICE}" = "RPi5" ]; then
    PKG_DEPENDS_TARGET+=" systemd"
    PKG_NEED_UNPACK+=" $(get_pkg_directory systemd)"
    PKG_FFMPEG_V4L2+=" ${PKG_FFMPEG_REQUEST_ENABLE}"
  else
    PKG_FFMPEG_V4L2+=" ${PKG_FFMPEG_REQUEST_DISABLE}"
  fi
else
  PKG_FFMPEG_V4L2="--disable-v4l2_m2m ${PKG_FFMPEG_REQUEST_DISABLE}"
fi

if [ "${VAAPI_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" libva"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libva)"
  PKG_FFMPEG_VAAPI="--enable-vaapi"
else
  PKG_FFMPEG_VAAPI="--disable-vaapi"
fi

if [ "${DISPLAYSERVER}" != "x11" ]; then
  PKG_DEPENDS_TARGET+=" libdrm"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libdrm)"
  PKG_FFMPEG_VAAPI=" --enable-libdrm"
fi

if build_with_debug; then
  PKG_FFMPEG_DEBUG="--enable-debug --disable-stripping"
else
  PKG_FFMPEG_DEBUG="--disable-debug --enable-stripping"
fi

if target_has_feature neon; then
  PKG_FFMPEG_FPU="--enable-neon"
else
  PKG_FFMPEG_FPU="--disable-neon"
fi

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

if target_has_feature "(neon|sse)"; then
  PKG_DEPENDS_TARGET+=" dav1d"
  PKG_NEED_UNPACK+=" $(get_pkg_directory dav1d)"
  PKG_FFMPEG_AV1="--enable-libdav1d"
else
  PKG_FFMPEG_AV1="--disable-libdav1d"
fi

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

if [ "${FFMPEG_TESTING}" = "yes" ]; then
  PKG_FFMPEG_TESTING="--enable-encoder=wrapped_avframe --enable-muxer=null"
  PKG_FFMPEG_TESTING+=" --enable-encoder=rawvideo --enable-muxer=rawvideo"
  PKG_FFMPEG_TESTING+=" --enable-muxer=image2 --enable-muxer=md5 --enable-muxer=framemd5"
  if [ "${PROJECT}" = "RPi" ]; then
    PKG_FFMPEG_TESTING+=" --enable-vout-drm --enable-outdev=vout_drm"
  fi
else
  PKG_FFMPEG_TESTING="--disable-programs"
fi

configure_target() {
  ./configure --prefix="/usr" \
              --cpu="${TARGET_CPU}${TARGET_CPU_FLAGS}" \
              --arch="${TARGET_ARCH}" \
              --enable-cross-compile \
              --cross-prefix="${TARGET_PREFIX}" \
              --sysroot="${SYSROOT_PREFIX}" \
              --sysinclude="${SYSROOT_PREFIX}/usr/include" \
              --target-os="linux" \
              --nm="${NM}" \
              --ar="${AR}" \
              --as="${CC}" \
              --cc="${CC}" \
              --ld="${CC}" \
              --host-cc="${HOST_CC}" \
              --host-cflags="${HOST_CFLAGS}" \
              --host-ldflags="${HOST_LDFLAGS}" \
              --extra-cflags="${CFLAGS}" \
              --extra-ldflags="${LDFLAGS}" \
              --extra-libs="${PKG_FFMPEG_LIBS}" \
              --disable-static \
              --enable-shared \
              --enable-gpl \
              --enable-version3 \
              --enable-logging \
              --disable-doc \
              ${PKG_FFMPEG_DEBUG} \
              --enable-pic \
              --pkg-config="${TOOLCHAIN}/bin/pkg-config" \
              --enable-optimizations \
              --disable-extra-warnings \
              --enable-avdevice \
              --enable-avcodec \
              --enable-avformat \
              --enable-swscale \
              --enable-avfilter \
              --disable-devices \
              --enable-pthreads \
              --enable-network \
              --disable-gnutls --enable-openssl \
              --disable-gray \
              --enable-swscale-alpha \
              --disable-small \
              ${PKG_FFMPEG_V4L2} \
              ${PKG_FFMPEG_VAAPI} \
              --disable-vdpau \
              ${PKG_FFMPEG_RPI} \
              --enable-runtime-cpudetect \
              --disable-hardcoded-tables \
              --disable-encoders \
              --enable-encoder=ac3 \
              --enable-encoder=eac3 \
              --enable-encoder=aac \
              --enable-encoder=wmav2 \
              --enable-encoder=mjpeg \
              --enable-encoder=png \
              ${PKG_FFMPEG_HWACCEL} \
              --disable-muxers \
              --enable-muxer=spdif \
              --enable-muxer=adts \
              --enable-muxer=asf \
              --enable-muxer=ipod \
              --enable-muxer=mpegts \
              --enable-demuxers \
              --enable-parsers \
              --enable-bsfs \
              --enable-protocol=http \
              --disable-indevs \
              --disable-outdevs \
              --enable-filters \
              --disable-avisynth \
              --enable-bzlib \
              --disable-lzma \
              --disable-alsa \
              --disable-frei0r \
              --disable-libopencore-amrnb \
              --disable-libopencore-amrwb \
              --disable-libopencv \
              --disable-libdc1394 \
              --disable-libfreetype \
              --disable-libgsm \
              --disable-libmp3lame \
              --disable-libopenjpeg \
              --disable-librtmp \
              ${PKG_FFMPEG_AV1} \
              --enable-libspeex \
              --disable-libtheora \
              --disable-libvo-amrwbenc \
              --disable-libvorbis \
              --disable-libvpx \
              --disable-libx264 \
              --disable-libxavs \
              --enable-libxml2 \
              --disable-libxvid \
              --enable-zlib \
              --enable-asm \
              --disable-altivec \
              ${PKG_FFMPEG_FPU} \
              --disable-symver \
              ${PKG_FFMPEG_TESTING}
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/ffmpeg/examples
}
