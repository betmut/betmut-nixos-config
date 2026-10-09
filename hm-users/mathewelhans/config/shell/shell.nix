{config, configPath, pkgs, lib, ...}: {

  stylix.targets.starship.enable = false;

  #enable zsh 
  programs.zsh = {
    enable = true;
    initContent = let 
      nixShellPrompt = lib.mkOrder 1000 (builtins.readFile ./scripts/nix_shell_prompt.sh);
      nushellAutoLaunch = lib.mkOrder 1000 (builtins.readFile ./scripts/nushell_auto_launch.sh);
      spotify-notifier = lib.mkOrder 1000 "systemctl --user start spotify-notifier";
    in
    lib.mkMerge [
      spotify-notifier 
      nixShellPrompt
      nushellAutoLaunch
    ];
  };

  #enable nushell
  programs.nushell = {
    enable = true;
    plugins =  with pkgs.nushellPlugins; [
      gstat   # Git status plugin
      polars  # dataframe plugin commands based on polars
    ];
    envFile.text = ''
      $env.config.history.max_size = 100_000
      $env.config.buffer_editor = 'vim'
      $env.EDITOR = 'vim'
      $env.NIXOS_CONFIG = ($env.HOME)/betmut-nixos-config
    '';
    extraConfig = ''
      alias projects = cd ($env.HOME)/Documents/Projects
      alias nixos-config = cd $env.NIXOS_CONFIG
    '';
  };

  #Modern CLI tools
  home.packages = with pkgs; [
    starship  # modern prompt framework
    
    bat       # modern cat replacement
    eza       # modern ls replacement
    fd        # modern find replacement
    zoxide    # modern cd replacement that learns your habits
  ];
}
