{ config, pkgs, ... }: {

  services.qbittorrent = {     # Port 8080
    enable = true;
    openFirewall = true;
  };

  # Override the systemd service to set your desired umask
  systemd.services.qbittorrent = {
    serviceConfig = {
      UMask = "0002";
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
}