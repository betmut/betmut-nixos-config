{ config, pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./ssh.nix
    ./bittorent-client.nix
    ./systemd-services.nix
    ./location.nix
    ./rstudio-server.nix
  ];
}