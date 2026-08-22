{config, pkgs, inputs, lib, ... }: {

  systemd.user.services.wallpaper-switch = {
    description = "Automatic Light/Dark Wallpaper Switcher";
    #wantedBy = [ "multi-user.target" ];  
    # Add this line! It makes notify-send available to the script
    path = with pkgs; [ 
      waypaper 
      procps
      coreutils
      bash
      curl
      libnotify
      gawk
    ] ++ [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${../scripts/change-wallpaper.sh}";
      Type = "oneshot";
      User = "mathewelhans";
    };
  };

  systemd.user.timers.wallpaper-switch = {
    description = "Automatic Light/Dark Wallpaper Switcher";
    wantedBy = [ "timers.target" ]; # This starts the timer on boot
    
    timerConfig = {
      Unit = "wallpaper-switch.service";
      OnCalendar = [
        "*-*-* 06:02:00"
        "*-*-* 18:02:00"
      ];
      Persistent = true;
    };
  };
}