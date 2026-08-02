{config, pkgs, inputs, ... }:
let
	desktopEnvironment = "hyprland";
in
{
	imports = [
		#linux modules
    ./linux/default.nix
        
    #services
    ./services/default.nix
    ./services/mac-hardware.nix

    #desktop environment
    (../desktop-environment + "/${desktopEnvironment}/${desktopEnvironment}.nix")
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
