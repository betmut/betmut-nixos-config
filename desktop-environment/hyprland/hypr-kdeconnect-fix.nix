{ pkgs, ...}:

pkgs.stdenv.mkDerivation {
  pname = "hypr-kdeconnect-fix";
  version = "git";

  src = pkgs.fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hypr-kdeconnect-fix";
    rev = "master";
    hash = "sha256-OW18+pO92XvlTLrHo+S9/EVUophr5Dl1GdGJcmVAq/o="; 
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    wayland-scanner
    qt6.wrapQtAppsHook
  ];

  buildInputs = with pkgs; [
    qt6.qtbase
    qt6.qtwayland
    wayland
    libxkbcommon
    libei
  ];
}