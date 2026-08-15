{ pkgs, ...}:

pkgs.waybar.overrideAttrs (oldAttrs: {
    # Override the fetchFromGitHub options
    src = pkgs.fetchFromGitHub {
      owner = "alexays";      # Your github username/org
      repo = "waybar";        # Repo name
      rev = "d4a44172106e26ddc5e95e007202113d3141d03a";   # Git commit SHA, branch name, or tag
      hash = "sha256-su7t3Ub+XH8xxI1WRLzTjVgSd6p9R4dSUGdc9AHYROM=";
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
      "-Dbuildtype=release"
      "-Ddebug=false"
    ];
})
