{config, pkgs, lib, ...}: {

  #enable zsh 
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = let 
      nixShellPrompt = lib.mkOrder 1000 (builtins.readFile ./scripts/nix_shell_prompt.sh);
      spotify-notifier = lib.mkOrder 1000 "systemctl --user start spotify-notifier";
    in
    lib.mkMerge [
      spotify-notifier 
      nixShellPrompt
    ];
  };

  #enable starship
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;
      character = {
        success_symbol = "[~>](bold green)";
        error_symbol = "[~>](bold red)";
      };
    };
  };

  #Modern CLI tools
  home.packages = with pkgs; [
    bat     # modern cat replacement
    eza     # modern ls replacement
    fd      # modern find replacement
    zoxide  # modern cd replacement that learns your habits
  ];
}
