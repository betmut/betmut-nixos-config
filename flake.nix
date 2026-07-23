{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable"; 
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-26.05";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, ... }: 
  let
    # Run scutil --get LocalHostName > ./hostname/mac to get your Mac Hostname (Please double check it!)
    macHostname = nixpkgs.lib.removeSuffix "\n" (builtins.readFile ./hostname/mac);
    linuxHostname = nixpkgs.lib.removeSuffix "\n" (builtins.readFile ./hostname/linux);
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
      initialPassword = "";
    };
  in
  {
    packages.x86_64-linux.minimal-iso = inputs.nixos-generators.nixosGenerate {
      inherit system;
      format = "install-iso";
      modules = (mkHomeUser {user = "nixos"; filePath = ./hm-users/nixos/home.nix;}) ++ [
        ({pkgs,...}:{users.users.nixos = userDefaults;})
        ./minimal-iso-config.nix
      ];
    };

    packages.x86_64-linux.vbox = inputs.nixos-generators.nixosGenerate {
      inherit system;
      format = "virtualbox";
      modules = (mkHomeUser {user = "nixos"; filePath = ./hm-users/nixos/home.nix;}) ++ [
        ({pkgs, ...}:{
          virtualisation.virtualbox.guest.enable = true;
          users.users.nixos = userDefaults;
        })
        ./configuration.nix
      ];
    };

    nixosConfigurations.${linuxHostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = 
      (mkHomeUser {user = "mathewelhans"; filePath = ./hm-users/mathewelhans/home.nix;}) ++
      (mkHomeUser {user = "guest"; filePath = ./hm-users/guest/home.nix;}) ++ [
        inputs.stylix.nixosModules.stylix
        inputs.agenix.nixosModules.default
        ./configuration.nix
        ./stylix.nix
        ./hardware-configuration.nix
        ./filesystems.nix
        ./desktop-environment/de-configuration.nix
        ./users.nix
      ];
    }; 

    darwinConfigurations.${macHostname} = inputs.nix-darwin.lib.darwinSystem {
      modules = (mkHomeUser {user = "macUser"; filePath = ./hm-users/macUser/home.nix;}) ++ [
        ({pkgs, config,  ...}: {
          # Optional: Align homebrew taps config with nix-homebrew
          homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
          nixpkgs.hostPlatform = "x86_64-darwin";
          users.users.macUser = userDefaults;
        })
        ./configuration.nix
        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = nixpkgs.pkgs.stdenv.hostPlatform.isAarch64;

            # User owning the Homebrew prefix
            user = "macUser";

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
          };
        }
      ];
    };
  };
}
