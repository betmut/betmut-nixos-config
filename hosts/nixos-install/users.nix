{lib, config, pkgs, inputs, ... }: 
let 
  userConfig = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["users" "audio" "networkmanager" "video" "render"];
  };
in
{
  
  users.users.awooga = userConfig // {
    extraGroups = userConfig.extraGroups ++ [ 
      "wheel" 
      "gamemode"
    ];
    home = "/home/awooga";
    initialPassword = "301103";
    initialHashedPassword = lib.mkForce null;
  };
}