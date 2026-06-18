{config, pkgs, lib, ...}: {

  #zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "battery"];
      theme = "xiong-chiamiov-plus";
    };    
    initContent = let 
      zshRPROMPT = lib.mkOrder 1000 (builtins.readFile ../../../dotfiles/shell/custom_prompt.sh);
      nixShellPrompt = lib.mkOrder 1000 (builtins.readFile ../../../dotfiles/shell/nix_shell_prompt.sh);
      spotify-notifier = lib.mkOrder 1000 "systemctl --user start spotify-notifier";
    in
    lib.mkMerge [zshRPROMPT spotify-notifier nixShellPrompt];
    #Content to be added to {file}`.zshrc`.

    #To specify the order, use `lib.mkOrder`.

    #Common order values:
    #- 500 (mkBefore): Early initialization (replaces initExtraFirst)
    #- 550: Before completion initialization (replaces initExtraBeforeCompInit)
    #- 1000 (default): General configuration (replaces initExtra)
    #- 1500 (mkAfter): Last to run configuration

    #To specify both content in Early initialization and General configuration, use `lib.mkMerge`.

    #e.g.

    #initContent = let
    #               zshConfigEarlyInit = lib.mkOrder 500 "do something";
    #               zshConfig = lib.mkOrder 1000 "do something";
    #              in
    #               lib.mkMerge [ zshConfigEarlyInit zshConfig ];
  };

  #hyprland config
  #programs.kitty.enable = true;
  #wayland.windowManager.hyprland.enable = true;
  #wayland.windowManager.hyprland.settings = {
  #  "$mod" = "SUPER";
  #};
}