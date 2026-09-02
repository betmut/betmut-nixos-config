{darwin-username, darwin-system, hm-pkgs, ... }: {
  nixpkgs.hostPlatform = darwin-system;
  system.primaryUser = darwin-username;

  users.users.${darwin-username} = {
    name = darwin-username;
    home = "/Users/${darwin-username}";
    shell = hm-pkgs.zsh;
  };
}