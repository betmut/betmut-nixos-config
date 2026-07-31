{pkgs, lib, ... }: {

  imports = [
    ./config/vim.nix
    ./config/zsh.nix
    ./config/fastfetch/fastfetch.nix
  ];
  home.stateVersion = "26.05";
  
  #Packages
  home.packages = with pkgs; [
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
