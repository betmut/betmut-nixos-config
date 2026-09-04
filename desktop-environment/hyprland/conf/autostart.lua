-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
local home = os.getenv("HOME")
local waybarPath = home .. "/betmut-nixos-config/desktop-environment/waybar"
local swayncPath = home .. "/betmut-nixos-config/desktop-environment/swaync"

hl.on("hyprland.start", function () 
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("waybar -c " .. waybarPath .. "/config.jsonc -s " .. waybarPath .. "/style.css || waybar")
  hl.exec_cmd("swaync -c " .. swayncPath .. "/config.json -s " .. swayncPath .. "/style.css || swaync")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("swayosd-server")
  hl.exec_cmd("nm-applet & blueman-applet & gammastep-indicator")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)
