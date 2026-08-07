{ pkgs, ...}:

pkgs.stdenv.mkDerivation {
  pname = "hypr-kdeconnect-fix";
  version = "git";

  src = pkgs.fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hypr-kdeconnect-fix";
    rev = "e86a0fb17826cb8ea987665ded7428534e4a1a9d";
    hash = "sha256-VcXxVtlnkPjO6l0ky/n+0qa87Uc3c8hRM0twfgl+AiM="; 
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
