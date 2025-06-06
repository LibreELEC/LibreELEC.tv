# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rpi-eeprom"
PKG_VERSION="b08dff7e46329af656ea93bb8ab504a68c39322d"
PKG_SHA256="bfc2248a36b5f31f366b8ee505022a9b19603ff8a16b1f549fde43ad30800469"
PKG_LICENSE="BSD-3/custom"
PKG_SITE="https://github.com/raspberrypi/rpi-eeprom"
PKG_URL="https://github.com/raspberrypi/rpi-eeprom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="pciutils"
PKG_LONGDESC="rpi-eeprom: firmware, config and scripts to update RPi4 SPI bootloader"
PKG_TOOLCHAIN="manual"

makeinstall_target() {

  if [ "${DEVICE}" = "RPi4" ]; then
    _variant="2711"
  else
    _variant="2712"
  fi

  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/raspberrypi/bootloader-${_variant}

  mkdir -p ${DESTDIR}
    _dirs="default latest"

    for _maindir in ${_dirs}; do
      for _dir in ${PKG_BUILD}/firmware-${_variant}/${_maindir} ${PKG_BUILD}/firmware-${_variant}/${_maindir}-*; do
        [ -d "${_dir}" ] || continue

        _basedir="$(basename "${_dir}")"

        mkdir -p ${DESTDIR}/${_basedir}
          cp -PRv ${_dir}/recovery.bin ${DESTDIR}/${_basedir}

          # Bootloader SPI
          PKG_FW_FILE="$(ls -1 /${_dir}/pieeprom-* 2>/dev/null | tail -1)"
          [ -n "${PKG_FW_FILE}" ] && cp -PRv "${PKG_FW_FILE}" ${DESTDIR}/${_basedir}

          if [ "${DEVICE}" = "RPi4" ]; then
            # VIA USB3
            PKG_FW_FILE="$(ls -1 ${_dir}/vl805-*.bin 2>/dev/null | tail -1)"
            [ -n "${PKG_FW_FILE}" ] && cp -PRv "${PKG_FW_FILE}" ${DESTDIR}/${_basedir}
          fi
      done
    done

    # also create legacy naming symlinks
    ln -s default ${DESTDIR}/critical
    ln -s latest ${DESTDIR}/stable

  mkdir -p ${INSTALL}/usr/bin
    cp -PRv ${PKG_DIR}/source/rpi-eeprom-update ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/rpi-eeprom-update ${INSTALL}/usr/bin/.rpi-eeprom-update.real
    cp -PRv ${PKG_BUILD}/rpi-eeprom-config ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/rpi-eeprom-digest ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/etc/default
    cp -PRv ${PKG_DIR}/config/* ${INSTALL}/etc/default
}
