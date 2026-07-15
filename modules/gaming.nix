{config, pkgs, inputs, lib, ... }: {
  # for performance mode
  programs.gamemode.enable = true; 

  programs.steam = {
    enable = true; # install steam
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true; # Enable gamescope session support
    extraCompatPackages = with pkgs; [
      # Add any additional compatibility packages here
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    mangohud
  ];
}