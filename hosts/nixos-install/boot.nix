{lib, config, pkgs, inputs, ... }: {

  #Overriding existing bootloader configuration
  #
  # if you use GRUB
  #boot.loader = {
  #  efi.canTouchEfiVariables = lib.mkForce false;
  #  grub = {
  #    enable = true;
  #    device = "nodev";
  #    efiSupport = true;
  #    efiInstallAsRemovable = true; # Copies grub to /EFI/BOOT/BOOTX64.EFI
  #  };
  #}; 

  # if you use systemd-boot
  #boot.loader = {
  #  grub.enable = lib.mkForce false;
  #  efi.canTouchEfiVariables = lib.mkForce false;
  #  systemd-boot.enable = true;
  #};
}