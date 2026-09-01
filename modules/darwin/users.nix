{ hm-pkgs, ... }:
let
  username = "darwin";
  hostPlatform = "aarch64-darwin";
in
{
  nixpkgs.hostPlatform = "${hostPlatform}";
  system.primaryUser = "${username}";

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
    shell = hm-pkgs.zsh;
  };
}