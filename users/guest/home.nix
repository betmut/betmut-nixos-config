{config, pkgs, lib, ... }: {

  imports = [
    ./config/vim.nix
    ./config/zsh.nix
    ./config/hyprpaper.nix
    ./config/hyprpaper.nix

  ];
  home.stateVersion = "25.11";
  #gtk.gtk4.theme = config.gtk.theme;

  
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
