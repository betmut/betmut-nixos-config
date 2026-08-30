{config, hm-pkgs, ...}:{

  programs.firefox = {
    enable = true;
    package = hm-pkgs.firefox;
    languagePacks = [ "en-US" "id"];

    policies = {
      DisableTelemetry = true;
    };
  };
}