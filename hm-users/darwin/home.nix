{lib, pkgs, ... }: 
let
  config-files = lib.filesystem.listFilesRecursive ./config;
in
{
  imports = builtins.filter (file: lib.hasSuffix ".nix" file) config-files;
  home.stateVersion = "26.05";
  
  #Packages
  home.packages = with pkgs; [nodejs python3 htop cmatrix];
  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };
}
