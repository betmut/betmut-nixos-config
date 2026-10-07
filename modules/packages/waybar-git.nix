{ pkgs, ...}:

pkgs.waybar.overrideAttrs (oldAttrs: {
    # Override the fetchFromGitHub options
    src = pkgs.fetchFromGitHub {
      owner = "alexays";      # Your github username/org
      repo = "waybar";        # Repo name
      rev = "16843896794a9c595139318420f81f40e84f8c78";   # Git commit SHA, branch name, or tag
      hash = "sha256-udymEQjGzKq9sg/4ag0zwY3N+FXIY20sUCwsbebFg84=";
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
