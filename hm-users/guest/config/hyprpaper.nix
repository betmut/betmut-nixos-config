{config, pkgs, lib,...}: 
  let 
    githubUrl = "https://raw.githubusercontent.com/AngelJumbo/gruvbox-wallpapers/refs/heads/main";
    kurumiWallpaper = pkgs.fetchurl {
      url = "${githubUrl}/wallpapers/anime/Kurumi-Ebisuzawa.png";
      sha256 = "sha256-M9eZZeJWmAT1R6k+wLj2f4Rj0c1Yz90CB4du0CFIwuY=";
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
          path = "${kurumiWallpaper}";
        }
      ];
    };
  };
}
