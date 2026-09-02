{darwin-username, hm-pkgs, ... }: {
  nixpkgs.hostPlatform = hm-pkgs.stdenv.hostPlatform.system;
  system.primaryUser = darwin-username;

  users.users.${darwin-username} = {
    name = darwin-username;
    home = "/Users/${darwin-username}";
    shell = hm-pkgs.zsh;
  };
}