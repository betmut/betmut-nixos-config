{config, pkgs, inputs, lib, ... }: {
  
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    
  #For promptless recording on both CLI and GUI
  programs.gpu-screen-recorder.enable = true; 

  #Zsh Shell
  programs.zsh.enable = true;

  # Allow proprietary software (Required for Broadcom)
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-59-6.18.38"
    ];
  };

    # Broadcom BCM4360 for MacBook's WiFi module dan zSwap for optimizing memory
  boot = {
    initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod"];
    initrd.kernelModules = [ "wl" "i915" "lz4"];
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_xanmod; #optimized linux kernel
    kernelModules = [ "wl" "kvm-intel"];
    kernelParams = [
      "zswap.enabled=1" # enables zswap
      "zswap.compressor=lz4" # compression algorithm
      "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
      "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
    ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

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

  services = rec {
    logind.settings.Login.HandlePowerKey = "ignore";

    #thermald
    thermald.enable = true;

    #blueman
    blueman.enable = true;

    #gvfs
    gvfs.enable = true;

    #glib-networking for TLS/SSL support 
    gnome.glib-networking.enable = true;

    #Enable the OpenSSH Daemon
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "mathewelhans" ];
      };
    };
    
    #Enable fail2ban
    fail2ban.enable = if (openssh.enable == true) then true else false;

    #enable warp daemons
    cloudflare-warp.enable = true;
      
    #mbpfan -- fan controller daemon for Apple Macs and MacBook
    mbpfan = {
      enable = true;
      aggressive = false;
      settings = {
        general = {
          low_temp = 63;  # If temperature is below this, fans will run at minimum speed.
          high_temp = 66; # If temperature is above this, fan speed will gradually increase.
          max_temp = 86; # If temperature is above this, fans will run at maximum speed.
        };
      };
    };
  };
}