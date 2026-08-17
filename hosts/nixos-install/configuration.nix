{lib, config, pkgs, inputs, ... }: 
let
  linuxmodulesPath = ../../modules/linux;
  servicesPath = ../../modules/services;
in
{
  system.stateVersion = "26.05";

  # Define Hostname
  networking.hostName = lib.removeSuffix "\n" (builtins.readFile ../../hostname/nixos-install);

  imports = [
    #essential linux modules & services
    (linuxmodulesPath + /default.nix)
    (servicesPath + /default.nix)
    
    #other essentials settings
    ../../disks.nix
    ../../nix-settings.nix
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

  #You can override the configuration right here like bootloader, users, etc.

  #Overriding existing bootloader configuration
  #GRUB
  #boot.loader = {
  #  efi.canTouchEfiVariables = lib.mkForce false;
  #  grub = {
  #    enable = true;
  #    device = "nodev";
  #    efiSupport = true;
  #    efiInstallAsRemovable = true; # Copies grub to /EFI/BOOT/BOOTX64.EFI
  #  };
  #}; 

  #systemd-boot
  #boot.loader = {
  #  efi.canTouchEfiVariables = lib.mkForce false;
  #  systemd-boot.enable = true;
  #};

  # Add a user!
  #users.users.alice = {
  #  isNormalUser = true;
  #  description = "Alice";
  # extraGroups = [ "wheel" ]; # Sudo access
  #  shell = pkgs.bash;
  #  home = "/home/alice";
  #};
}