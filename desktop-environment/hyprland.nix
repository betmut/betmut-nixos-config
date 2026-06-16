{inputs, pkgs, ...}: 
  let
    platformSystem = pkgs.stdenv.hostPlatform.system;
    hyprlandPkgs = inputs.hyprland.packages.${platformSystem};
    pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${platformSystem};
    hypr-kdeconnect-fix = pkgs.callPackage ./hypr-kdeconnect-fix.nix { };  
  in
  {
    programs.hyprland = {
      enable = true;
      package = hyprlandPkgs.hyprland;
      portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      
      extraPortals = [
        hypr-kdeconnect-fix
        pkgs.xdg-desktop-portal-gtk
      ];

      config = {
        hyprland = {
          default = [ "hyprland" "gtk" ];
          "org.freedesktop.impl.portal.RemoteDesktop" = "hypr-kdeconnect";
        };
      };
    };

    #basic apps
    environment.systemPackages = with pkgs; [
      kitty                       #terminal
      rofi                        #app launcher
      thunar
      yazi                        #file manager
      hyprpaper                   #wallpaper daemon
      hypridle
      hyprlock
      waybar                      #status bars
      swaynotificationcenter      #notification bars
      libnotify                   #notification
      networkmanagerapplet        #networkManager Applet
      brightnessctl 
      wireplumber
      gnome-font-viewer
      guvcview
      zscroll

      #screenshot tools
      grim
      slurp
      swappy
      wf-recorder
      wl-clipboard
      gpu-screen-recorder-gtk # GUI app

      gapless #music
      wlogout
      swayosd
    ];

    environment.etc = {
      #waybar config
      "xdg/waybar/config".source = ../dotfiles/waybar/gruvbox/config;
      "xdg/waybar/style.css".source = ../dotfiles/waybar/gruvbox/style.css;
      "xdg/waybar/scripts".source = ../dotfiles/waybar/gruvbox/scripts;
      
      #swayNC config 
      "xdg/swaync/config.json".source = ../dotfiles/swaync/config.json;
      "xdg/swaync/style.css".source = ../dotfiles/swaync/style.css;

      #wlogout config
      #"wlogout/layout".source = ../dotfiles/wlogout/layout;
      #"wlogout/style.css".source = ../dotfiles/wlogout/style.css;
    };

    hardware.graphics = {
      enable = true;
      package = pkgs-unstable.mesa;

      #enable 32 bit support
      enable32Bit = true;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;

      extraPackages = with pkgs; [
        # Explicit driver for Intel HD 6000 / Broadwell video acceleration
        intel-vaapi-driver 
        # Libva utilities to help you test if it works
        libva-utils
      ];
    };
  }
