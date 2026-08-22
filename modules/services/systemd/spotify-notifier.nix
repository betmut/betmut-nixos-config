{config, pkgs, inputs, lib, ... }: {

  systemd.user.services.spotify-notifier = {
    description = "Spotify Song Notifier";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    path = with pkgs; [
      libnotify 
      playerctl
      curl
    ];
    
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${../scripts/spotify-notifiers.sh}";
      Restart = "on-failure";
      RestartSec = "5";
      #Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
    };
  };

  
}