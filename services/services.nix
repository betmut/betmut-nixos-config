{config, pkgs, inputs, lib, ... }: {

  nixpkgs.overlays = [
    (final: prev: {
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    })
  ];

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
    tumbler.enable = true;

    #rstudio-server
    rstudio-server = {
      enable = true; #set to true if you want to enable rstudio-server
      listenAddr = "127.0.0.1";
      package = pkgs.pkgs-stable.rstudioServerWrapper.override { 
        packages = with pkgs.pkgs-stable.rPackages; [ 
          tidyverse 
        ]; 
      };
    };

    #transmission
    #transmission = {
    #  enable = true;
    #  package = pkgs.transmission_4;
    #  openRPCPort = true;
    #  settings = {
    #    #config.services.transmission.home </var/lib/transmission>
    #    download-dir = "${config.services.transmission.home}/Downloads";
 
    #    rpc-port = 9091;
    #    rpc-bind-address = "127.0.0.1";
    #    rpc-whitelist = "127.0.0.1"; #Whitelist your remote machine
    #    umask = "002"; # Allow group-write access, blocking the rest of the world.
    #  };
    #};

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
}
