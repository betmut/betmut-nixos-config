{config, pkgs, inputs, lib, ... }:
let
  # 1. Python environment bundled with Pillow
  pythonEnv = pkgs.python313.withPackages (ps: [
    ps.pillow
  ]);

  # 2. Mock fetch tool to return a format update_theme.py understands: "Packages: <count> (nix)"
  fakeFetch = pkgs.writeShellScriptBin "fastfetch" ''
    # Count installed paths in the system profile
    PKG_COUNT=$(ls -d /nix/var/nix/profiles/system/sw/bin/* 2>/dev/null | wc -l)
    echo "Packages: $PKG_COUNT (nix)"
  '';

  # 3. Wrapper script
  minegrubUpdateScript = pkgs.writeShellScript "minegrub-update" ''
    cd /boot/grub/themes/minegrub
    export PATH="${fakeFetch}/bin:${pythonEnv}/bin:$PATH"
    ${pythonEnv}/bin/python3 update_theme.py
  '';
in
{
 systemd.services.minegrub-update = {
    description = "Update Minegrub splash text and background";
    after = [ "local-fs.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${minegrubUpdateScript}";
      # Ensures the service runs as root to have write permissions in /boot
      User = "root";
    };
  }; 
}