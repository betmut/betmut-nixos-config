{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable"; 
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

  outputs = inputs@{ self, nixpkgs, ... }: 
  let
    # Run scutil --get LocalHostName > ./hostname/mac to get your Mac Hostname (Please double check it!)
    macHostname = nixpkgs.lib.removeSuffix "\n" (builtins.readFile ./hostname/mac);
    linuxHostname = nixpkgs.lib.removeSuffix "\n" (builtins.readFile ./hostname/linux);

    sharedModules = {user, filePath}: [
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
      extraGroups = ["wheel"]; #sudo privillege
      initialPassword = "";
    };
  in
  {
    packages.x86_64-linux.minimal-iso = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "install-iso";
      modules = (sharedModules {user = "nixos"; filePath = ./users/nixos/home.nix;}) ++ [
        ({pkgs,...}:{users.users.nixos = userDefaults;})
        ./configuration.nix
      ];
    };

    packages.x86_64-linux.vbox = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "virtualbox";
      modules = (sharedModules {user = "nixos"; filePath = ./users/nixos/home.nix;}) ++ [
        ({pkgs, ...}:{
          virtualisation.virtualbox.guest.enable = true;
          users.users.nixos = userDefaults;
        })
        ./configuration.nix
      ];
    };

    nixosConfigurations.${linuxHostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = 
      (sharedModules {user = "mathewelhans"; filePath = ./users/mathewelhans/home.nix;}) ++
      (sharedModules {user = "guest"; filePath = ./users/guest/home.nix;}) ++ [
        ({config, pkgs,...}:{
          users.users.mathewelhans = userDefaults // {
            extraGroups = ["transmission" "wheel" "audio" "networkmanager" "video" "render"];
          };
          users.users.guest = userDefaults // {
            extraGroups = [ "audio" "networkmanager" "video" "render"]; 
            hashedPassword = "guest";
          };
        })
        inputs.stylix.nixosModules.stylix
        inputs.agenix.nixosModules.default
        ./configuration.nix
        ./stylix.nix
        ./hardware-configuration.nix
        ./filesystems.nix
        ./desktop-environment/de-configuration.nix
      ];
    }; 

    darwinConfigurations.${macHostname} = inputs.nix-darwin.lib.darwinSystem {
      modules = (sharedModules {user = "macUser"; filePath = ./users/macUser/home.nix;}) ++ [
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
