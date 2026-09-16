#!/usr/bin/env bash

ICON_DIR="$HOME/.config/hypr/assets/wifi"
CURRENT="$ICON_DIR/wifi-status.png"

# nmcli returns "connected" when there is an active network connection.
if nmcli -t -f STATE general | grep -qx "connected"; then
    ln -sfn "$ICON_DIR/wifi.png" "$CURRENT"
else
    ln -sfn "$ICON_DIR/wifi-unconnect.png" "$CURRENT"
fi