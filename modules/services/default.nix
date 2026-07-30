{ config, pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./ssh.nix
    ./bittorrent-client.nix
    ./power-alerts.nix
    ./location.nix
    ./rstudio-server.nix
  ];
}