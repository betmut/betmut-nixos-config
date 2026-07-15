{config, pkgs, inputs, lib, ... }: {

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    
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
    };

    #Enable KDE Connect
    programs.kdeconnect.enable = true;

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

    #enable polkit
    security.polkit.enable = true;

    #Some programs need SUID wrappers, can be configured further or are
    #started in user sessions.
    #programs.mtr.enable = true;
    #programs.gnupg.agent = {
    #    enable = true;
    #    enableSSHSupport = true;
    #};
}
