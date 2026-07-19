{config, pkgs,...}: 
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
  };
  users.users.guest = userConfig // {
    initialPassword = "guest";
  };

  #users.users.radarr = {
  #  extraGroups = [ "qbittorrent"];
  #};

  #users.users.bazarr = {
  #  extraGroups = [ "radarr"];
  #};

  #users.users.qbittorrent = {
  #  extraGroups = [ "radarr"];
  #};
}