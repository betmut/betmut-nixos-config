{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable"; 
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-26.05";
    };

    nixpkgs-stable-darwin = {
      url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs-stable-darwin";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-darwin-stable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable-darwin";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
    };

    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, ... }: 
  let
    system = "x86_64-linux";
    mkHomeUser = {user, filePath}: [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          extraSpecialArgs = { inherit inputs; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = filePath;
          };
      }
    ];
    userDefaults = {
      shell = nixpkgs.legacyPackages.x86_64-linux.zsh;
      isNormalUser = true;
      extraGroups = ["users" "audio" "networkmanager" "video" "render"];
      initialPassword = "aezakmi";
      initialHashedPassword = nixpkgs.lib.mkForce null;
    };
  in
  {
    packages.x86_64-linux.minimal-iso = inputs.nixos-generators.nixosGenerate {
      inherit system;
      format = "install-iso";
      modules = (mkHomeUser {user = "nixos"; filePath = ./hm-users/nixos/home.nix;}) ++ [
        ({pkgs,...}:{users.users.nixos = userDefaults;})
        ./iso-configurations/minimal-iso-config.nix
      ];
    };

    nixosConfigurations.mySystem = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = 
      (mkHomeUser {user = "mathewelhans"; filePath = ./hm-users/mathewelhans/home.nix;}) ++
      (mkHomeUser {user = "guest"; filePath = ./hm-users/guest/home.nix;}) ++ [
        inputs.stylix.nixosModules.stylix
        inputs.agenix.nixosModules.default
        ./platforms/nixos-chapunk/configuration.nix
      ];
    }; 

    darwinConfigurations.darwinSystem = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.home-manager-darwin-stable.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
        ./platforms/darwin-macUser/configuration.nix
      ];
    };
  };
}