{ pkgs, ...}:

pkgs.waybar.overrideAttrs (oldAttrs: {
    # Override the fetchFromGitHub options
    src = pkgs.fetchFromGitHub {
      owner = "Alexays";      
      repo = "Waybar";        
      rev = "c15ec02ede4343592a59eb5c2ff4443c9c045f7c";   # Git commit SHA, branch name, or tag
      hash = "sha256-mBDWjeeIuFfDZQuBxHu+EpbJ+GMbbSxpRz0WVM2N+ZI=";
    };

    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
      pkgs.mold
    ];

    buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
      pkgs.modemmanager
    ];

    NIX_LDFLAGS = "-fuse-ld=mold";

    mesonFlags = (oldAttrs.mesonFlags or [ ]) ++ [
      "--buildtype=release"
      "-Dcava=disabled"
      "-Dtests=disabled"
      "-Djack=disabled"
      "-Dmango=false"          
    ];
})
