{config, pkgs, inputs, ... }: {

  # TV Series Automation
  services.sonarr = {
    enable = true;
    openFirewall = true; # Port 8989
  };

  # Movie Automation
  services.radarr = {
    enable = true;
    openFirewall = true; # Port 7878
  };

  # Indexer Manager
  services.prowlarr = {
    enable = true;
    openFirewall = true; # Port 9696
  };
}