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
      ExecStart = "${pkgs.bash}/bin/bash ${./scripts/spotify-notifiers.sh}";
      Restart = "on-failure";
      RestartSec = "5";
      #Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
    };
  };

  systemd.services.low-battery-notification = {
    description = "Running an low-battery-notification";
    #wantedBy = [ "multi-user.target" ];  
    # Add this line! It makes notify-send available to the script
    path = [ pkgs.libnotify ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${./scripts/low-battery-notification.sh}";
      Type = "oneshot";
      User = "mathewelhans";
      # Necessary to send notifications to your desktop from a service
      Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
    };
  };

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
    ] ++ [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${./scripts/change-wallpaper.sh}";
      Type = "oneshot";
      User = "mathewelhans";
    };
  };

  systemd.user.timers.wallpaper-switch = {
    description = "Automatic Light/Dark Wallpaper Switcher";
    wantedBy = [ "timers.target" ]; # This starts the timer on boot
    
    timerConfig = {
      Unit = "wallpaper-switch.service";
      OnBootSec = "1min";
      OnCalendar = [
        "*-*-* 06:02:00"
        "*-*-* 18:02:00"
      ];
      Persistent = true;
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
  #systemd.services."my-custom-service" = {
  #  description = "My Custom Shell Script Service";
  #  
  #  # Ensure the service starts after the network is up (optional)
  #  after = [ "network.target" ];
  #  wantedBy = [ "multi-user.target" ];
  #  
  #  serviceConfig = {
  #    Type = "simple";
  #    User = "root"; # Change to your username if root isn't needed
  #    Restart = "on-failure";
  #    RestartSec = "5s";
  #  };
  #  # This is where your .sh content goes
  #  script = ''
  #    #!/bin/sh
  #    echo "Service is starting..."
  #    ${pkgs.coreutils}/bin/mkdir -p /tmp/my-service
  #    while true; do
  #      echo "The time is $(date)" >> /tmp/my-service/log.txt
  #      sleep 60
  #    done
  #  '';
  #};
}