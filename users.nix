{config, pkgs,...}: 
let
  userConfig = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["users" "audio" "networkmanager" "video" "render"];
    initialPassword = "";
  };
in 
{
  users.users.mathewelhans = userConfig // {
    extraGroups = userConfig.extraGroups ++ [ 
      "wheel" 
      "transmission" 
      "sonarr"
      "radarr"
    ];
  };
  users.users.guest = userConfig // {
    hashedPassword = "guest";
  };

  users.users.radarr = {
    extraGroups = [ "transmission" ];
  };

  users.users.transmission = {
    extraGroups = [ "radarr" ];
  };
}