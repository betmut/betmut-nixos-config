{config, pkgs, inputs, lib, ... }: 
let
  services-config = lib.filesystem.listFilesRecursive ./systemd;
in
{
  imports = services-config;
}