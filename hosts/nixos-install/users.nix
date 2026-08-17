{config, pkgs, inputs, ... }: 
let 
  userConfig = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["users" "audio" "networkmanager" "video" "render"];
  };
in
{
  users.users.mathewelhans = userConfig // {
    extraGroups = userConfig.extraGroups ++ [ 
      "wheel" 
      "transmission" 
      "qbittorrent"
      "sonarr"
      "radarr"
      "bazarr"
      "gamemode"
    ];
    home = "/home/mathewelhans"
  };
  
  users.users.guest = userConfig // {
    initialPassword = "guest";
    home = "/home/guest"
  };
}