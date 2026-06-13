{config, pkgs, inputs, lib, ... }: {

  #age.secrets.transmission-rpc-whitelist = {
  #  file = ../secrets/transmission-rpc-whitelist.age;
  #};

  services = rec {
    logind.settings.Login.HandlePowerKey = "ignore";

    #thermald
    thermald.enable = true;

    #blueman
    blueman.enable = true;

    #gvfs
    gvfs.enable = true;

    #glib-networking for TLS/SSL support 
    gnome.glib-networking.enable = true;

    #tumbler for thumbnail management (like showing image thumbnail in thunar)
    services.tumbler.enable = true;

    #rstudio-server
    rstudio-server = {
      enable = true;
      listenAddr = "127.0.0.1";
      package = pkgs.rstudioServerWrapper.override { 
        packages = with pkgs.rPackages; [ 
          tidyverse 
        ]; 
      };
    };

    #transmission
    transmission = {
      enable = true;
      package = pkgs.transmission_4;
      openRPCPort = true;
      settings = {
        #config.services.transmission.home </var/lib/transmission>
        download-dir = "${config.services.transmission.home}/Downloads";
 
        rpc-port = 9091;
        rpc-bind-address = "127.0.0.1";
        rpc-whitelist = "127.0.0.1"; #Whitelist your remote machine
      };
    };

    #Enable the OpenSSH Daemon
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "mathewelhans" ];
      };
    };
    
    #Enable fail2ban
    fail2ban.enable = if (openssh.enable == true) then true else false;

    #enable warp daemons
    cloudflare-warp.enable = true;
      
    #mbpfan -- fan controller daemon for Apple Macs and MacBook
    mbpfan = {
      enable = true;
      aggressive = false;
      settings = {
        general = {
          low_temp = 63;  # If temperature is below this, fans will run at minimum speed.
          high_temp = 66; # If temperature is above this, fan speed will gradually increase.
          max_temp = 86; # If temperature is above this, fans will run at maximum speed.
        };
      };
    };
  };

  systemd.user.services.spotify-notifier = {
    description = "Spotify Song Notifier";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    path = with pkgs; [
      libnotify 
      playerctl
    ];
    
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${../dotfiles/shell/notifiers/spotify-notifiers.sh}";
      Restart = "always";
      RestartSec = "3";
      #Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
    };
  };

  systemd.services.low-battery-notification = {
    description = "Running an low-battery-notification";
    #wantedBy = [ "multi-user.target" ];  
    # Add this line! It makes notify-send available to the script
    path = [ pkgs.libnotify ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${../dotfiles/shell/notifiers/low-battery-notification.sh}";
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
