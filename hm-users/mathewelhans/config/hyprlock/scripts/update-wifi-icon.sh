#!/usr/bin/env bash

HYPRLOCK_DIR="$NIXOS_CONFIG/hm-users/mathewelhans/config/hyprlock"
ICON_DIR="$HYPRLOCK_DIR/assets/wifi"
CURRENT="$ICON_DIR/wifi-status.png"

# nmcli returns "connected" when there is an active network connection.
if nmcli -t -f STATE general | grep -qx "connected"; then
    ln -sfn "$ICON_DIR/wifi.png" "$CURRENT"
else
    ln -sfn "$ICON_DIR/wifi-unconnect.png" "$CURRENT"
fi