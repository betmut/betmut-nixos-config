{ pkgs, ...}:

pkgs.waybar.overrideAttrs (oldAttrs: {
    # Override the fetchFromGitHub options
    src = pkgs.fetchFromGitHub {
      owner = "alexays";      # Your github username/org
      repo = "waybar";        # Repo name
      rev = "4c495a41f6fe5689665783138ce0097f9b757e0a";   # Git commit SHA, branch name, or tag
      hash = "sha256-udymEQjGzKq9sg/4ag0zwY3N+FXIY20sUCwsbebFg84=";
    };

    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
      pkgs.mold
    ];

    buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
      pkgs.modemmanager
    ];

    NIX_LDFLAGS = "-fuse-ld=mold";

    # Disable CAVA to prevent Meson from looking for the missing subproject
    mesonFlags = (oldAttrs.mesonFlags or [ ]) ++ [
      "-Dcava=disabled"
      "-Dtests=disabled"
      "--buildtype=release"
      "-Ddebug=false"
      "-Dniri=false"          # Disable niri compilation
    ];
})
