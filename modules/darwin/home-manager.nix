{ inputs, ... }:

{
  imports = [
    inputs.home-manager-darwin-stable.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.macUser = import ../../hm-users/macUser/home.nix;
  };
}