{darwin-username, inputs, ... }:{  
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs;};
    users.${darwin-username} = import ../../hm-users/${darwin-username}/home.nix;
  };
}