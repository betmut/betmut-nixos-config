{self, lib, config, pkgs, inputs, ... }: 
let
	desktopEnvironment = "hyprland";
  linuxmodulesPath = ../../modules/linux;
  servicesPath = ../../modules/services;
in
{
  system.stateVersion = "26.05";
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Define Hostname
  networking.hostName = lib.removeSuffix "\n" (builtins.readFile ../../hostname/nixos-chapunk);

  imports = [
    #essential linux modules & services
    (linuxmodulesPath + /default.nix)
    (servicesPath + /default.nix)

    #other essentials settings
    ../../stylix.nix
    ../../disks-backup.nix
    ../../nix-settings.nix
    ./users.nix

    #linux modules
    (linuxmodulesPath + /display-manager.nix)
    (linuxmodulesPath + /gaming.nix)
    (linuxmodulesPath + /ephemeral-guest.nix)
    (linuxmodulesPath + /fonts.nix)
    (linuxmodulesPath + /security.nix)
    (linuxmodulesPath + /podman.nix)
    
    #services
    (servicesPath + /mac-hardware.nix)
    (servicesPath + /rstudio-server.nix)
    (servicesPath + /systemd-services.nix)

    #desktop environment
    (../../desktop-environment + "/${desktopEnvironment}/${desktopEnvironment}.nix")
  ];

  #Environment Variables
  environment.variables = {
    EDITOR = "nano";
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_CONFIG = "$HOME/betmut-nixos-config";
  };

  #Aliases
  environment.shellAliases = {
    nixos-config = "cd $NIXOS_CONFIG";
    projects = "cd $HOME/Documents/Projects || cd $HOME/Projects";
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
