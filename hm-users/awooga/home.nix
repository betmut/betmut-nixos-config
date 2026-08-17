{config, pkgs, lib, ... }: {

  imports = [
    ./config/vim/vim.nix
    ./config/zsh/zsh.nix
    ./config/fastfetch/fastfetch.nix

  ];
  home.stateVersion = "26.05";

  home.pointerCursor.enable = true;
    
  #Packages
  home.packages = with pkgs; [
    htop 
    cmatrix 
    brightnessctl 
    playerctl
    wireplumber
    fastfetch
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };
}
