#!/bin/sh

################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

# exit 1 = unsupported GPU
# exit 2 = dual boot system
# exit 3 = no backup file, therefore no restore
# exit 4 = extlinux.conf and syslinux.cfg are available
# exit 5 = changes are already made either to extlinux.conf or syslinux.cfg
# exit 6 = xorg.conf already exists in /storage/.config
# exit 7 = no xorg.conf in /storage/.config



# Help message and usage explanation
help() {
echo "This script generates a custom EDID depending on your GPU"
echo ""
echo "To check which GPU you are using, use: ./getedid.sh gpu"
echo ""
echo "To create a custon EDID, just use this script like: ./getedid.sh start"
echo ""
echo "If you already used that script and want to temporarly get thing back like it was before use: ./getedid.sh restore"
echo ""
echo "If you don't want to use the created EDID file anymore use: ./getedid.sh delete"
echo ""
echo "If you hardware has changed and you want to have a custom EDID again, then you have to delete the old EDID first."
echo "For this use: ./getedid.sh delete "
echo "And then use: ./getedid.sh start"
}

# check for GPU and store string
check_gpu() {
  if lspci | grep -i vga | grep -i -q intel ; then
    gpu="intel"
  elif lspci | grep -i vga | grep -i -q nvidia; then
    gpu="nvidia"
  else
    echo "GPU is not supported"
    exit 1
  fi
}


# run this first if the user already has a custom EDID but want to create a new one (TV or AVR change)
del_edid() {
  if [ "$gpu" = "intel" ]; then
    check_file
    if [ -f "$file".old ];  then
      mount_rw
      rm "$file"
      mv "$file".old "$file"
      mount_ro
      rm -r /storage/cpio
      rm -r /storage/.config/firmware
      sys_reboot
    else
      echo "You don't have a backup file for $file. You didn't used this script to create the custom EDID"
      echo "Therefore we can't be sure the script working prooerly. Exiting"
      exit 3
    fi
  elif [ "$gpu" = "nvidia" ]; then
    if [ -f /storage/.config/xorg.conf ]; then
      rm /storage/.config/xorg.conf
    fi
    if [ -f /storage/.config/xorg.le.backup ]; then
      rm /storage/.config/xorg.le.backup
    fi
    sys_reboot
  fi   
}

# run main script depending on the GPU
run() {
  if [ "$gpu" = "intel" ]; then
    intel 
  elif [ "$gpu" = "nvidia" ]; then
    nvidia
  fi
}


# mounting /flash to rw
mount_rw() {
  mount -o remout,rw /flash
}


# remount /flash to ro and reboot
sys_reboot() {
  mount -o remount,ro /flash
  echo "The system is rebooting in 15 seconds"
  sleep 15
  reboot
}


# check syslinux.cfg and/or extlinux.conf
check_file() {

  #check which file is available
  if [ -f /flash/syslinux.cfg ] && [ -f /flash/extlinux.conf ];then
    echo "Your system contains both. A /flash/syslinux.cfg and a /flash/extlinux.conf file"
    echo "Something is wrong on your system. Exiting"
    exit 4
  elif [ -f /flash/extlinux.conf ];then
    file="/flash/extlinux.conf"
  elif [ -f /flash/syslinux.cfg ];then
    file="/flash/syslinux.cfg"
  else
    echo "You neither have a extlinux.conf nor do you have a syslinux.cfg."
    echo "Dual boot systems aren't supported"
    exit 2
  fi
}

check_content() {
  # check if changes are already made to $file and exit if yes
  if [ "$(grep "APPEND" $file)" = " APPEND boot=LABEL=System disk=LABEL=Storage ssh quiet" ]; then
    echo "You alread did some changes to $file. Exiting."
    exit 5
  fi
}


# restore the backup done by the script and depending on the GPU
restore() {

  # intel
  if [ "$gpu" = "intel" ]; then
    check_file
    mount_rw
    if [ -f "$file".old ]; then
      rm "$file"
      cp "$file".old "$file"  # cp because of keeping the backup...just in case
    else
      echo "You didn't created a custom EDID yet or you didn't use this script for this task."
      echo "Therefore we can't ensure the script working properly."
      echo "Exiting"
      exit 3
    fi
  elif [ "$gpu" = "nvidia" ]; then # start for nvidia 
    if [ -f /storage/.config/xorg.conf ]; then
      mv /storage/.config/xorg.conf /storage/.config/xorg.le.backup
    else
      echo "You don't have a xorg.conf in your .config folder. Exiting"
      exit 7
    fi
  fi
  sys_reboot
}


intel() {
  
  #check which output is connnected:
  for i in /sys/class/drm/*; do
    if [ "$(cat "$i"/status 2>/dev/null)" = "connected" ]; then
      hdmi="$(echo "$i" | cut -d / -f 5 | sed 's/card[0-9]-//g')"
    fi
  done

  #create edid
  mkdir -p /storage/.config/firmware/edid
  cat /sys/class/drm/"$hdmi"/edid > /storage/.config/firmware/edid/edid.bin

  #create cpio archive
  cd /storage
  mkdir -p cpio/lib/firmware/edid
  cp /storage/.config/firmware/edid/edid.bin /storage/cpio/lib/firmware/edid/
  cd cpio/
  find . -print | cpio -ov -H newc > /storage/edid.cpio


  #remount /flash to rw
  mount_rw
  mv /storage/edid.cpio /flash/

  #check extlinux.conf and syslinux.cfg
  check_file
  check_content
  # make a backup of $file
  cp "$file" "$file".old

  #add things to $file
  sed -i "/ APPEND/s/$/ initrd=/edid.cpio drm_kms_helper.edid_firmware=$hdmi:edid/edid.bin video=$hdmi:D/" "$file"

  #reboot
  sys_reboot
}


nvidia() {

  # check if xorg.conf already exists
  if [ -f /storage/.config/xorg.conf ]; then
    echo "You already have a modified xorg.conf. Therefore we can't ensure the script working properly. Exiting."
    exit 6
  elif [ -f /storage/.config/xorg.le.backup ]; then # check if backup created by this script exists
    mv /storage/.config/xorg.le.backup /storage/.config/xorg.conf
    sys_reboot
  fi

  # determine the connected port. The command substituion should return 'dfp-x' only. Where x stands for a number from 0-9 
  nv_port="$(cat /var/log/Xorg.0.log | grep -i -w connected | grep -i -o "dfp-[0-9]" | head -n 1)"
  
  # Getting Xorg into debug mode
  # stop Xorg first
  systemctl stop xorg.service
  
  # clone xorg.conf
  cp /etc/X11/xorg-nvidia.conf /storage/.config/xorg.conf

  # enable debug
  sed -i 's/"ModeDebug" "false"/"ModeDebug" "true"/g' /storage/.config/xorg.conf

  # restart Xorg
  systemctl start xorg.service


  # create the EDID file
  nvidia-xconfig --extract-edids-from-file=/var/log/Xorg.0.log --extract-edids-output-file=/storage/.config/edid.bin 1>/dev/null

  # set mode debug back to false
  sed -i 's/"ModeDebug" "true"/"ModeDebug" "false"/g' /storage/.config/xorg.conf
  
  # uncomment specific lines and change the matching dfp-x
  sed -i "s/#    Option         \"ConnectedMonitor\" \"DFP-0\"/    Option         \"ConnectedMonitor\" \"$nv_port\"/g" /storage/.config/xorg.conf
  sed -i "s/#    Option         \"CustomEDID\" \"DFP-0:\/storage\/.config\/edid.bin\"/    Option         \"CustomEDID\" \"\"$nv_port\":\/storage\/.config\/edid.bin\"/g" /storage/.config/xorg.conf
  sed -i "s/#    Option         \"IgnoreEDID\" \"false\"/    Option         \"IgnoreEDID\" \"false\"/g" /storage/.config/xorg.conf
  sed -i "s/#    Option         \"UseEDID\" \"true\"/    Option         \"UseEDID\" \"true\"/g" /storage/.config/xorg.conf

  # restart xorg.service
  systemctl restart xorg.service

  #reboot system
  sys_reboot
}


# start script from here
case "$1" in
  'start')
    check_gpu
    run
    ;;
  'restore')
    check_gpu
    restore
    ;;
  'gpu')
    check_gpu
    echo "$gpu"
    ;;
  'delete')
    check_gpu
    del_edid
    ;;
  'help')
    help
    ;;
  *)
    echo "Usage $0 { start | restore | gpu | delete | help }"
    ;;
esac
