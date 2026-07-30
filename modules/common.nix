{config, pkgs, pkgs-stable, inputs, ... }: {
    
    imports = [
        #linux modules
        ./linux/boot.nix
        ./linux/ephemeral-guest.nix
        ./linux/fonts.nix
        ./linux/gaming.nix
        ./linux/hardware.nix
        ./linux/kernel.nix
        ./linux/networking.nix
        ./linux/programs-core.nix
        ./linux/security.nix
        ./linux/system-basics.nix
        ./linux/users.nix
        
        #services
        ./services/services.nix
        ./services/media-automation.nix
        ./services/power-alerts.nix
        ./services/location.nix
        ./services/rstudio-server.nix
    ];

    #Environment Variables
    environment.variables = {
        EDITOR = "nano";
        LIBVA_DRIVER_NAME = "iHD";
    };

    # Optional: Add useful tools
    environment.systemPackages = with pkgs; [
        cloudflare-warp
        tmux 
        tree
        git 
        vim 
        pciutils # Useful for 'lspci'
        quickemu
        cron
        wireguard-tools
        iptables
    ] ++ [
        pkgs-stable.warzone2100
    ];
}
