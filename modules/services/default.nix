{ config, pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./ssh.nix
    ./bittorent-client.nix
    ./location.nix
  ];
}