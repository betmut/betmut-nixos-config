{pkgs, lib, inputs, ... }: 
let
  config-files = lib.filesystem.listFilesRecursive ./config;
in
{
  imports = builtins.filter (file: lib.hasSuffix ".nix" file) config-files;
  home.stateVersion = "26.05";
  
  #Packages
  home.packages = with pkgs; [
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    htop 
    cmatrix
    tmux 
    tree
    git  
    pciutils # Useful for 'lspci'
    ntfs3g        # Provides 'ntfs-3g' and 'ntfsfix'
    apfs-fuse     # FUSE driver for Apple APFS
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };
  
}
