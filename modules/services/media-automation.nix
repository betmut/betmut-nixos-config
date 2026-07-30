{config, pkgs, inputs, ... }:
let 
  mediaServiceConfig = {
    enable = true;
    openFirewall = true;
  };
in
{
  # TV Series Automation
  services.sonarr = mediaServiceConfig // {enable = false;};        # Port 8989

  # Movie Automation
  services.radarr = mediaServiceConfig // {enable = false;};        # Port 7878

  # Indexer Manager
  services.prowlarr = mediaServiceConfig // {enable = false;};      # Port 9696

  # Subtitle Manager
  services.bazarr = mediaServiceConfig // {enable = false;};        # Port 6767
}