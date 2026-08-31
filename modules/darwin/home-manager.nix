{ inputs, hm-pkgs, ... }: {
  
  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; inherit hm-pkgs;};
    users.darwin = import ../../hm-users/darwin/home.nix;
  };
}