{inputs, config, hm-pkgs, ...}:{

  programs.firefox = {
    enable = true;
    package = hm-pkgs.firefox;
    languagePacks = [ "en-US" "id"];
    policies = {
      DisableTelemetry = true;
      BackgroundAppUpdate = false;
      AppAutoUpdate = false;
    };

    profiles = {
      guest = {
        # bookmarks, extensions, search engines...
        search.default = "Google";
        extensions = {
          packages = with inputs.firefox-addons.packages."x86_64-linux"; [
            ghostery
            enhanced-h264ify
          ];
        };
      };
    };
  };
}