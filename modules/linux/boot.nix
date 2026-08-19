{pkgs, inputs, config, ...}: 
let
  minegrub-theme = pkgs.fetchFromGitHub {
    owner = "Lxtharia";
    repo = "minegrub-theme";
    rev = "dev"; # Or a specific commit hash
    sha256 = "sha256-tCHT7ZL4Fen/Y8Nv3c6iRdPx+1ZceUbGwREWPcZlQ3w="; # Replace with actual hash or run nix-prefetch-url
  };

  minegrub-world-sel = pkgs.fetchFromGitHub {
    owner = "Lxtharia";
    repo = "minegrub-world-sel-theme";
    rev = "dev";
    sha256 = "sha256-Hlp081T6HUd4n6CaTf3aousZwBuBly6+0T+Y2d5y+SE=";
  };

  minegrub-double-menu = pkgs.fetchFromGitHub {
    owner = "Lxtharia";
    repo = "minegrub-double-menu";
    rev = "dev";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
in
{
  #Bootloader configuration
  boot.loader = {
    efi.canTouchEfiVariables = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;

      # 1. Set the initial theme to the world-selection theme
      theme = "${minegrub-world-sel}/minegrub-world-selection";

      # 2. Copy the second theme and the secondary config file to /boot/grub/
      extraFiles = {
        "grub/themes/minegrub" = "${minegrub-theme}/minegrub";
        "grub/mainmenu.cfg" = "${minegrub-double-menu}/mainmenu.cfg";
      };

      # 3. Inject the logic from 05_twomenus into grub.cfg
      extraConfig = ''
        exec tail -n +3 $0
        
        if [ -z "$chosen" ] ; then
          if [ "${config_file}" ] ; then
            configfile $prefix/$config_file
          fi
        fi
      '';
    };
  };
}
