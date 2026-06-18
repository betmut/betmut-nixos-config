{config, pkgs,...}: 
let
  userConfig = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["audio" "networkmanager" "video" "render"];
    initialPassword = "";
  };
in 
{
  users.users.mathewelhans = userConfig // {
    extraGroups = userConfig.extraGroups ++ [ 
      "wheel" 
      "transmission" 
    ];
  };
  users.users.guest = userConfig // {
    hashedPassword = "guest";
  };
}