{config, pkgs, inputs, ... }: {

  #For promptless recording on both CLI and GUI
  programs.gpu-screen-recorder.enable = true; 

  #Zsh Shell
  programs.zsh.enable = true;

  #enable thunar (file manager)
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin 
      thunar-volman 
      thunar-media-tags-plugin
      thunar-vcs-plugin
    ];
  };

  #Enable Firefox
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" "id"];

    preferences = {
      "ui.textHighlightBackground" = "#4e635b";
      "media.hardwaremediakeys.enabled" = true;
    };

    policies = {
      DisableTelemetry = true;
    };
  };

  #Enable KDE Connect
  programs.kdeconnect.enable = true;
}