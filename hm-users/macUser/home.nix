{pkgs, lib, ... }: {

  imports = [
    ./config/vim.nix
    ./config/zsh.nix
    ./config/fastfetch/fastfetch.nix
  ];
  home.stateVersion = "26.05";
  
  #Packages
  home.packages = with pkgs; [nodejs python3 R gemini-cli htop cmatrix];
  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };
}
