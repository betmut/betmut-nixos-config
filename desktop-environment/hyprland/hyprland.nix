{inputs, pkgs, ...}: 
let
  hypr-kdeconnect-fix = pkgs.callPackage ../../modules/packages/hypr-kdeconnect-fix.nix { };  
  zscroll = pkgs.callPackage ../../modules/packages/zscroll.nix { };
in
{
  programs.hyprland = {
    enable = true;
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

    #enable 32 bit support
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
      # Libva utilities to help you test if it works
      libva-utils
    ];
  };

  #basic apps
  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprpolkitagent             #graphical password prompt

    libnotify                   #notification
    networkmanagerapplet        #networkManager Applet
    brightnessctl 
    wireplumber
    gnome-font-viewer
    guvcview
    swayosd
    wlogout
    catfish                     #file search tool
    ffmpegthumbnailer           #generate video thumbnail previews
    file-roller                 #archive manager
    mpv                         #media player
    ghostscript                 #PostScript interpreter
    lm_sensors

    #screenshot tools
    grim
    slurp
    swappy
    wl-clipboard
    gpu-screen-recorder-gtk # screen recorder 

    #wallpaper
    waypaper
    awww
  ] ++ 
  [
    zscroll
  ];
}
