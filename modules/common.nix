{config, pkgs, pkgs-stable, inputs, ... }: {
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
