{config, pkgs, inputs, lib, ... }: {
  
  # Networking

  networking.networkmanager = {
    enable = true;
    dns = "none";
    wifi.powersave = true;
  };

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  # Configure DNS servers manually (this example uses Cloudflare and Google DNS)
  # IPv6 DNS servers can be used here as well.
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];
  
  networking.firewall = rec {
    enable = true;
    checkReversePath = "loose"; # Fixes dropped return packets
    allowedTCPPorts =  [ 8787 ]; #22 9091 8787
    allowedUDPPorts = [ 51820 ];
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
    #    allowedUDPPorts = [];
  };

  #networking.proxy = {
  #    default = "http://user:password@proxy:port/";
  #    noProxy = "127.0.0.1,localhost,internal.domain";
  #};
}