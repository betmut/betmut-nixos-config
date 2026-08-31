{pkgs, inputs,...}: {
  
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    polarity = "dark";
    
    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.whitesur-icon-theme; 
      dark = "WhiteSur-dark";
      light = "WhiteSur-light";
    };

    fonts = {
      serif = {
        package = pkgs.newcomputermodern;
        name = "NewComputerModern10";
      };
      
      sansSerif = {
        package = pkgs.ubuntu-sans;
        name = "Ubuntu Sans";
      };
      
      monospace = {
        package = pkgs.nerd-fonts.hasklug;
        name = "Hasklug Nerd Font Mono";
      };
      
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12; # GUI apps (like Firefox menus, file managers)
        terminal = 14;     # Your terminal emulator (Alacritty, Kitty, etc.)
        desktop = 10;      # Desktop widgets, bars, and notifications
        popups = 10;       # Tooltips and small menus
      };
    };

    targets = {
      grub.enable = false;
      console.enable = false;
    };
    opacity.terminal = 0.7;
  };
}
