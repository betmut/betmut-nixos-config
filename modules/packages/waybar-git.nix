{ pkgs, ...}:

pkgs.waybar.overrideAttrs (oldAttrs: {
    # Override the fetchFromGitHub options
    src = pkgs.fetchFromGitHub {
      owner = "alexays";      # Your github username/org
      repo = "waybar";        # Repo name
      rev = "09e69e0f48214a1128d62417612bc47e8dc9e36a";   # Git commit SHA, branch name, or tag
      hash = "sha256-grYWj1RHrkhM0NCIymTsZyObuQsCVf1kuzLaThwMxvc=";
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
