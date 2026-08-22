{config, pkgs, inputs, lib, ... }: 
let
  services-config = lib.filesystem.listFilesRecursive ./systemd;
in
{
  imports = services-config;

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