#!/bin/bash

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

LANG=en_US.UTF-8
export LANG

. /etc/os-release

PARAM="$@"

# help
if [ "$1" = "--help" -o "$1" = "-h" ]; then
  echo "$0 [--vgaport <port>]"
  exit 0
fi

## workaround for Adler Lake and later GPU
# https://forum.libreelec.tv/thread/27886-intel-alder-lake-2160p-23-976-hz-passthrough-hd-audio-dropouts-i7-1270p-n100/

# on ADL10 image no workaround needed
if [ "${LIBREELEC_DEVICE}" = "Generic-ADL10" -o -f /storage/.dont-activate-10-bit-max ]; then
  echo "INFO: you running Generic-ADL10 where the kernel has a fix"
  echo "      or you touched /storage/.dont-activate-10-bit-max"
  echo "      so nothing will be done"
  exit 0
fi

BIT=10
NOT="max ${BIT} bit not activated"

# do we have a Intel GPU
lspci | grep -qEi 'VGA .* Intel '
if [ $? -ne 0 ]; then
  echo "No Intel GPU found, ${NOT}"
  exit
fi

# command line / eviroment check
if [ "$1" = "--vgaport" -a -n "$2" ]; then
  VGAPORT="$2"
  shift
  shift
fi
if [ -n "${VGAPORT}" ]; then
  grep -q 'connected$' /sys/class/drm/card*${VGAPORT}/status
  if [ $? -eq 0 ]; then
    grep -q '^connected$' /sys/class/drm/card*${VGAPORT}/status
    if [ $? -ne 0 ]; then
      echo "WARN: VGAPORT=${VGAPORT} is not connected, try to activate max ${BIT} anyway"
    fi
    PORT="${VGAPORT}"
  else
    echo "ERROR: port ${VGAPORT} not found"
    NAMEs="$(grep -l 'connected$' /sys/class/drm/card*/status | awk -F/ '{ print $5 }' | sed -e 's|^card[^-]*-||' | tr '\n' ' ')"
    echo "       choose one of ${NAMEs}"
    exit 1
  fi
fi

# find the port
if [ -z "${PORT}" ]; then
  PORTs=$(grep '^connected$' /sys/class/drm/card*/status | wc -l)
  if [ "${PORTs}" = "1" ]; then
    PORT=$(grep -l '^connected$' /sys/class/drm/card*/status | awk -F/ '{ print $5 }' | sed -e 's|^card[^-]*-||')
  elif [ ! "${PORTs}" = "0" ]; then
    NAMEs="$(grep -l '^connected$' /sys/class/drm/card*/status | awk -F/ '{ print $5 }' | sed -e 's|^card[^-]*-||' | tr '\n' ' ')"
    echo "ERROR: found connected ports ${NAMEs}, autodetect works only with 1"
  fi
fi
if [ -z "${PORT}" ]; then
  echo "ERROR: could not find the VGA porti to use"
  NAMEs="$(grep -l 'connected$' /sys/class/drm/card*/status | awk -F/ '{ print $5 }' | sed -e 's|^card[^-]*-||' | tr '\n' ' ')"
  echo "       choose one of ${NAMEs} and run"
  echo "       ${0} --vgaport <port>"
  exit 1
fi

# find the connector
CONNECTOR=$(modetest -c | grep -E "[[:space:]]${PORT}[[:space:]]" | awk '{ print $1 }')
if [ -z "${CONNECTOR}" ]; then
  echo "ERROR: connector id for port ${PORT} not found"
  exit 1
fi

echo "using VGA port $PORT with connector id $CONNECTOR"

# only if kodi is not running
systemctl is-active kodi.service --quiet
if [ $? -eq 0 ]; then
  echo "ERROR: kodi is running, ${NOT}"
  echo "# try the following line"
  echo "systemctl stop kodi.service && $0 "${PARAM}" && systemctl start kodi.service"
else
  modetest -w ${CONNECTOR}:"max bpc":${BIT}
fi

