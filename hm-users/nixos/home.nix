{pkgs, lib, ... }: {

  imports = [
    ./config/vim.nix
    ./config/zsh.nix
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
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };
  
}
