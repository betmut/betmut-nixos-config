#!/usr/bin/env bash

nix flake update nixpkgs \
                 nixpkgs-stable \
                 stylix  \
                 firefox-addons \
                 sysc-greet \
                 home-manager
