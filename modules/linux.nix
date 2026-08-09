{config, pkgs, inputs, ... }: {
	imports = [
	#essential linux modules & services
    ./linux/default.nix
    ./services/default.nix
  ];

  #Environment Variables
  environment.variables = {
	EDITOR = "nano";
    LIBVA_DRIVER_NAME = "iHD";
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
	tmux 
    tree
    git 
    vim 
    pciutils # Useful for 'lspci'
    quickemu
    cron
    wireguard-tools
    iptables
  ];
}
