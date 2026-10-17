{pkgs, inputs, config, ...}: {
  #Bootloader configuration
  boot.loader = {
    efi.canTouchEfiVariables = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;

      double-minegrub-menu = {
        enable = true;
        
        # main menu configurations
        main_menu_background = "random";
        splash_text = "100% Declarative";
            
        # world selection configurations
        world_selection_background_scaled = "1366x768";
        world_selection_custom_icons = with config.system; [
          {
            inherit name;
            lineTop = with nixos; distroName + " " + codeName + " (" + version + ")";
            lineBottom = "Survival Mode, No Cheats, Version: " + nixos.release;

            # Icon: you can use an icon from the remote repo, or load from a local file
            imgName = "nixos";

            # customImg = builtins.path {
            #   path = ./nixos-logo.png;
            #   name = "nixos-img";
            # };
          }
        ];
      };
    };
  };
}
