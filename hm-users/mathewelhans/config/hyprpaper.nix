{config, pkgs, lib,...}: 
  let 
    wallpaper = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/totoro_bus_stand.png";
      sha256 = "aG+fl1RO/N23hj2e+Oy/8Osbo5CEW68dTDZ2JU1hNfw=";
    };
  in {
  #Hyprpaper config
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "eDP-1";
          path = "${wallpaper}";
        }
      ];
    };
  };
}