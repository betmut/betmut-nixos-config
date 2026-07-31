{ lib, python3Packages, fetchFromGitHub, ... }:

python3Packages.buildPythonApplication rec {
  pname = "zscroll";
  version = "2.0.1";

  # Nixpkgs requires explicitly setting build-system for setup.py packages
  pyproject = true;

  src = fetchFromGitHub {
    owner = "noctuid";
    repo = "zscroll";
    rev = "2.0.1";
    hash = "sha256-gEluWzCbztO4N1wdFab+2xH7l9w5HqZVzp2LrdjHSRM=";
  };

  build-system = [
    python3Packages.setuptools
    python3Packages.poetry-core
  ];

  meta = with lib; {
    description = "A text scroller for news ticks, status bars, and panels";
    homepage = "https://github.com/noctuid/zscroll";
    license = licenses.gpl3Only;
    mainProgram = "zscroll";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp zscroll $out/bin/
    chmod +x $out/bin/zscroll
  '';
}