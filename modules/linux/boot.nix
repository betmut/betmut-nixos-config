{pkgs, inputs, config, ...}: 
let
  minegrub-theme = pkgs.fetchFromGitHub {
    owner = "Lxtharia";
    repo = "minegrub-theme";
    rev = "89f9e24f44cbe06b11d69068e39f534666e4d3d3"; # Or a specific commit hash
    sha256 = "sha256-wusELfq9vxbkbZy8cPprcOldqoqSbKltxt++EW9gQ9g="; # Replace with actual hash or run nix-prefetch-url
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
    sha256 = "sha256-JkTUy/j2H1Et8vvN2BCMX37DAPcQHqMTpQ667NbVpOk=";
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
      extraFiles = let
        themeDir = "${minegrub-theme}/minegrub";
        bgDir = "${minegrub-theme}/background_options";

        allFiles = pkgs.lib.filesystem.listFilesRecursive themeDir;
        allBgs = pkgs.lib.filesystem.listFilesRecursive bgDir;

        # Strip the base themeDir prefix to get the relative subpath for each file
        themeFileEntries = builtins.listToAttrs (map (file: {
          name = builtins.unsafeDiscardStringContext (
            "grub/themes/minegrub" + pkgs.lib.removePrefix (toString themeDir) (toString file)
          );
          value = file;
        }) allFiles);

        bgFileEntries = builtins.listToAttrs (map (file: {
          name = builtins.unsafeDiscardStringContext (
            "grub/themes/minegrub/backgrounds" + pkgs.lib.removePrefix (toString bgDir) (toString file)
          );
          value = file; 
        }) allBgs);
      in
      {
        "grub/mainmenu.cfg" = "${minegrub-double-menu}/mainmenu.cfg";
      } // themeFileEntries // bgFileEntries;

      # 3. Inject the logic from 05_twomenus into grub.cfg
      extraConfig = ''
        exec tail -n +3 $0
        
        if [ -z "$chosen" ] ; then
          if [ "''${config_file}" ] ; then
            configfile $prefix/$config_file
          fi
        fi
      '';
    };
  };
}
