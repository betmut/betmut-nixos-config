{ pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "macUser";

  users.users.macUser = {
    name = "macUser";
    home = "/Users/macUser";
    shell = pkgs.zsh;
  };
}