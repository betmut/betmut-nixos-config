{pkgs, inputs, config, ...}: {
  
  #Bootloader configuration
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    efi.canTouchEfiVariables = false;
  };
}
