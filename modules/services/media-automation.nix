{config, pkgs, inputs, ... }:
let 
  mediaServiceConfig = {
    enable = true;
    openFirewall = true;
  };
in
{
  services.qbittorrent = mediaServiceConfig;   # Port 8080

  # TV Series Automation
  services.sonarr = mediaServiceConfig // {enable = false;};        # Port 8989

  # Movie Automation
  services.radarr = mediaServiceConfig // {enable = false;};        # Port 7878

  # Indexer Manager
  services.prowlarr = mediaServiceConfig // {enable = false;};      # Port 9696

  # Subtitle Manager
  services.bazarr = mediaServiceConfig // {enable = false;};        # Port 6767

  # Override the systemd service to set your desired umask
  systemd.services.qbittorrent = {
    serviceConfig = {
      UMask = "0002";
    };
  };
}