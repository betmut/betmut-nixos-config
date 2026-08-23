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
      url = "github:nix-community/home-manager/release-26.05";
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
    isoConfig = type: {
      inherit system;
      format = "install-iso";
      modules = (mkHomeUser {user = "nixos"; filePath = ./hm-users/nixos/home.nix;}) ++ [
        ./iso-configurations/${type}
      ];
    };
  in
  {
    packages.x86_64-linux.minimal-iso = inputs.nixos-generators.nixosGenerate (
      isoConfig "minimal-iso-config.nix");

    packages.x86_64-linux.gnome-iso = inputs.nixos-generators.nixosGenerate (
      isoConfig "gnome-iso-config.nix");

    nixosConfigurations.erdos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = 
      (mkHomeUser {user = "mathewelhans"; filePath = ./hm-users/mathewelhans/home.nix;}) ++
      (mkHomeUser {user = "guest"; filePath = ./hm-users/guest/home.nix;}) ++ [
        inputs.stylix.nixosModules.stylix
        inputs.agenix.nixosModules.default
        ./hosts/nixos-chapunk/configuration.nix
      ];
    }; 

    nixosConfigurations.nixos-install = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos-generate-config/configuration.nix
        ./nixos-generate-config/hardware-configuration.nix
      ];
    }; 

    darwinConfigurations.darwinSystem = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.home-manager-darwin-stable.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
        ./hosts/darwin-macUser/configuration.nix
      ];
    };
  };
}
