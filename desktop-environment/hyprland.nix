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

  #graphics settings
  hardware.graphics = {
    enable = true;
    package = pkgs-unstable.mesa;

    #enable 32 bit support
    enable32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;

    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
      # Libva utilities to help you test if it works
      libva-utils
    ];
  };

  #basic apps
  environment.systemPackages = with pkgs; [
    hyprpaper                   #wallpaper daemon
    hypridle
    hyprlock
    hyprpolkitagent             #graphical password prompt

    kitty                       #terminal
    yazi                        #file manager
    libnotify                   #notification
    networkmanagerapplet        #networkManager Applet
    brightnessctl 
    wireplumber
    gnome-font-viewer
    guvcview
    zscroll
    catfish                     #file search tool
    ffmpegthumbnailer           #generate video thumbnail previews
    file-roller                 #archive manager
    mpv                         #media player
    ghostscript                 #PostScript interpreter

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
}
