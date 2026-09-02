{
  inputs = {
    # System-wide packages channel
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable"; 
    };

    # Home Manager packages channel
    nixpkgs-hm = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable"; 
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
      inputs.nixpkgs.follows = "nixpkgs-hm";
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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-hm";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixpkgs-hm, ... }: 
  let
    linux-system = "x86_64-linux";
    hm-pkgs = import nixpkgs-hm { inherit linux-system; config.allowUnfree = true; };
    pkgs-stable = import nixpkgs-stable { inherit linux-system; config.allowUnfree = true; };
    mkHomeUser = {user, filePath}: [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          extraSpecialArgs = { inherit inputs hm-pkgs pkgs-stable;};
          useGlobalPkgs = false;
          useUserPackages = true;
          users.${user} = filePath;
          };
      }
    ];
    isoConfig = type: {
      inherit linux-system;
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
      inherit linux-system;
      specialArgs = { inherit inputs pkgs-stable;};
      modules = 
      (mkHomeUser {user = "mathewelhans"; filePath = ./hm-users/mathewelhans/home.nix;}) ++
      (mkHomeUser {user = "guest"; filePath = ./hm-users/guest/home.nix;}) ++ [
        inputs.stylix.nixosModules.stylix
        inputs.agenix.nixosModules.default
        ./hosts/nixos-erdos/configuration.nix
      ];
    }; 

    nixosConfigurations.nixos-install = nixpkgs.lib.nixosSystem {
      inherit linux-system;
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos-generate-config/configuration.nix
        ./nixos-generate-config/hardware-configuration.nix
      ];
    }; 

    darwinConfigurations.darwinSystem = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { 
        inherit inputs hm-pkgs;
        darwin-username = "darwin";
        darwin-system = "aarch64-darwin"; #or "x86_64-darwin" for intel macs
      };
      modules = [
        inputs.home-manager-darwin-stable.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
        ./hosts/darwin/configuration.nix
      ];
    };
  };
}
