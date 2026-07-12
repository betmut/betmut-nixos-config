{config, pkgs, lib, ... }: {

  imports = [
    ./config/vim/vim.nix
    ./config/zsh.nix
    ./config/hyprpaper.nix
    ./config/hyprpaper.nix
    ./config/rofi/rofi.nix
    ./config/waybar/waybar.nix
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
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };

  #.config files
  xdg.configFile = {
    
    "hypr/hyprland.lua".source = ../../dotfiles/hyprland/hyprland.lua;
    "hypr/conf".source = ../../dotfiles/hyprland/conf;

    "kitty/kitty.conf".source = ../../dotfiles/kitty/kitty.conf;
    "kitty/gruvbox-kitty.conf".source = ../../dotfiles/kitty/gruvbox-kitty.conf;

    "yazi/theme.toml".source = ../../dotfiles/yazi/theme.toml;
    "yazi/flavors".source  = ../../dotfiles/yazi/flavors;

    "fastfetch/config.jsonc".source = ../../dotfiles/fastfetch/config.jsonc;
};
}
