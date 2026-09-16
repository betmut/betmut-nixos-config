{darwin-username, darwin-system, pkgs, ... }: {
  nixpkgs.hostPlatform = darwin-system;
  system.primaryUser = darwin-username;

  users.users.${darwin-username} = {
    name = darwin-username;
    home = "/Users/${darwin-username}";
    shell = pkgs.zsh;
  };
}