{ config, pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./ssh.nix
    ./bittorent-client.nix
    ./power-alerts.nix
    ./location.nix
    ./rstudio-server.nix
  ];
}