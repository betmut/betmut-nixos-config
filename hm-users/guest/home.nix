{config, pkgs, lib, ... }: {

  imports = [
    ./config/vim/vim.nix
    ./config/zsh/zsh.nix
    ./config/hyprpaper.nix
    ./config/hyprpaper.nix
    ./config/rofi/rofi.nix
    ./config/waybar/waybar.nix
    ./config/kitty/kitty.nix
    ./config/fastfetch/fastfetch.nix
    ./config/yazi/yazi.nix
  ];
  home.stateVersion = "26.05";

  home.pointerCursor.enable = true;
    
  #Packages
  home.packages = with pkgs; [
    nodejs 
    python3 
    R 
    gemini-cli 
    htop 
    cmatrix 
    brightnessctl 
    playerctl
    wireplumber

    kitty
    fastfetch
    yazi
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };

  #.config files
  xdg.configFile = {
    
    "hypr/hyprland.lua".source = ../../desktop-environment/hyprland/hyprland.lua;
    "hypr/conf".source = ../../desktop-environment/hyprland/conf;
};
}
