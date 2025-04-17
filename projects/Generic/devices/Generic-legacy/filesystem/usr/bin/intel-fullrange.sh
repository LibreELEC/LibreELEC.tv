#!/bin/sh
FB_TYPE="$(grep '^0 ' /proc/fb | sed 's/[^[:space:]] //')"

if [ "$FB_TYPE" == "inteldrmfb" ] || echo "$FB_TYPE" | grep -q "^i9[0-9]*drmfb$"; then
  OUTPUT=$(/usr/bin/xrandr -display :0 -q | sed '/ connected/!d;s/ .*//;q')
  for out in $OUTPUT; do
    # Hack - something is not yet fully right
    /usr/bin/xrandr -display :0 --output $out --set "Broadcast RGB" "Full"
    # Seems there is a little race somewhere on some outputs
    # Turn the display shortly off and on again
    if [ -e "/storage/.config/forcedisplay" ]; then
      /usr/bin/xrandr -display :0 --output $out --off
      /usr/bin/xrandr -display :0 --output $out --auto
    fi
  done
fi
