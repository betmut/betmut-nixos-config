#!/usr/bin/env bash

LAYOUT_PATH="$HOME/betmut-nixos-config/desktop-environment/wlogout/layout"
CSS_PATH="$HOME/betmut-nixos-config/desktop-environment/wlogout/style.css"

wlogout \
  --layout "$LAYOUT_PATH" \
  --css "$CSS_PATH" \
  --buttons-per-row 4