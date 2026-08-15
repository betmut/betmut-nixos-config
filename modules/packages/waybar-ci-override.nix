{ pkgs, ... }:

pkgs.waybar.overrideAttrs (oldAttrs: {
  # Override the fetchFromGitHub options
  src = pkgs.fetchFromGitHub {
    owner = "alexays";
    repo = "waybar";
    rev = "d4a44172106e26ddc5e95e007202113d3141d03a";
    hash = "sha256-su7t3Ub+XH8xxI1WRLzTjVgSd6p9R4dSUGdc9AHYROM=";
  };

  buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
    pkgs.modemmanager
  ];

  # Disable CAVA to prevent Meson from looking for the missing subproject
  mesonFlags = (oldAttrs.mesonFlags or [ ]) ++ [
    "-Dcava=disabled"
  ];

  # Disable tests - this is CI-specific since the sleeper thread test is flaky
  doCheck = false;
})