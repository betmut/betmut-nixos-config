{ pkgs, ... }:
let
  username = "macUser";
  hostPlatform = "aarch64-darwin";
in
{
  nixpkgs.hostPlatform = "${hostPlatform}";
  system.primaryUser = "${username}";

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };
}