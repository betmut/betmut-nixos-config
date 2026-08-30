{ inputs, hm-pkgs, ... }: {
  
  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; inherit hm-pkgs;};
    users.macUser = import ../../hm-users/macUser/home.nix;
  };
}