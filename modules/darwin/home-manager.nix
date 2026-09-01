{darwin-username, inputs, hm-pkgs, ... }:{  
  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; inherit hm-pkgs;};
    users.${darwin-username} = import ../../hm-users/${darwin-username}/home.nix;
  };
}