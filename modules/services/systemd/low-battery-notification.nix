{config, pkgs, inputs, lib, ... }: {

  systemd.services.low-battery-notification = {
    description = "Running an low-battery-notification";
    #wantedBy = [ "multi-user.target" ];  
    # Add this line! It makes notify-send available to the script
    path = [ pkgs.libnotify ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${../scripts/low-battery-notification.sh}";
      Type = "oneshot";
      User = "mathewelhans";
      # Necessary to send notifications to your desktop from a service
      Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
    };
  };

  systemd.timers.low-battery-notification = {
    description = "Run low-battery-notification every 5 minutes";
    wantedBy = [ "timers.target" ]; # This starts the timer on boot
    
    timerConfig = {
      OnBootSec = "1m";       # Wait 2 mins after boot before first run
      OnUnitActiveSec = "1m"; # Then run every 5 mins after that
      Unit = "low-battery-notification.service";
    };
  };
}