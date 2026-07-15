{config, pkgs, inputs, ... }: {
    nixpkgs.overlays = [
    (final: prev: {
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    })
  ];

    #Environment Variables
    environment.variables = {
        EDITOR = "nano";
        LIBVA_DRIVER_NAME = "iHD";
    };

    # Optional: Add useful tools
    environment.systemPackages = with pkgs; [
        pkgs-stable.warzone2100
        cloudflare-warp
        tmux 
        tree
        git 
        vim 
        pciutils # Useful for 'lspci'
        fastfetch
        quickemu
        cron
        wireguard-tools
        iptables
    ];
}
