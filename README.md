# nixos-custom-iso

Personal NixOS + Home Manager configurations and a custom ISO builder (Flakes). Supports Linux and macOS (nix-darwin). Includes prebuilt outputs for install-ISO, VirtualBox, per-user Home Manager configs and Darwin system.

## Badges
- License: MIT

## Table of Contents
- Motivation
- Features
- Prerequisites
- Quickstart
  - Clone
  - Build ISO
  - Build VirtualBox image
  - Build / Switch NixOS system
  - Build / Switch Darwin system
- Flake outputs
- Directory layout
- Secrets (agenix)
- Contributing
- Troubleshooting
- License

## Motivation
Short explanation of why this repo exists: to maintain a reproducible, multi-host NixOS setup and to build a minimal install ISO and VirtualBox images with a single flake.

## Features
- Flakes-based builder and configurations
- ISO builder via nixos-generators
- VirtualBox image target
- Per-user Home Manager configs under `users/`
- Cross-platform support: `nix-darwin` integration for macOS
- Secrets handled via `agenix` (encrypted)

## Prerequisites
- Nix with flakes enabled (nix >= 2.4 recommended)
- For Darwin: nix-darwin installed
- For building ISO/images: `nix` with network access to fetch inputs
- Optional: `git` and `nix flake` auth if using private inputs

## Quickstart

1. Clone
```bash
git clone https://github.com/betmut/nixos-custom-iso.git
cd nixos-custom-iso
```

2. Build the minimal install ISO
```bash
# From repo root
nix build .#packages.x86_64-linux.minimal-iso
# Result is symlinked to ./result — inspect or copy to USB
ls -l result
```

3. Build the VirtualBox image
```bash
nix build .#packages.x86_64-linux.vbox
# The VirtualBox image will be in ./result
```

4. Build / switch a NixOS host configuration
- Find the host attribute used in `nixosConfigurations` (your flake defines it by reading hostname/linux).
- Example (replace `<hostname>` with the output of `cat hostname/linux`):
```bash
# Build:
nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel

# Switch (on the target machine, or chroot where appropriate):
sudo nixos-rebuild switch --flake .#<hostname>
```

5. Build / apply the Darwin configuration
```bash
# Build:
nix build .#darwinConfigurations.<mac-hostname>

# Apply on macOS:
darwin-rebuild switch --flake .#<mac-hostname>
```
Notes:
- Replace `<hostname>` and `<mac-hostname>` with the actual hostnames in `./hostname/linux` and `./hostname/mac`.
- When running from a different machine, ensure `specialArgs` inputs referenced by the flake are available.

## Flake outputs (what they are & how to use)
- `packages.x86_64-linux.minimal-iso` — an install ISO (use `nix build .#packages.x86_64-linux.minimal-iso`)
- `packages.x86_64-linux.vbox` — VirtualBox image (use `nix build .#packages.x86_64-linux.vbox`)
- `nixosConfigurations.<linuxHostname>` — NixOS system definition(s) for Linux hosts.
  - Use with `nixos-rebuild --flake .#<linuxHostname>`
- `darwinConfigurations.<macHostname>` — nix-darwin system definition for macOS hosts.
  - Use with `darwin-rebuild --flake .#<macHostname>`

## Directory layout (brief)
- `configuration.nix` — base system config used by both linux and darwin builds
- `hardware-configuration.nix` — hardware-specific settings
- `desktop-environment/` — Hyprland / display manager fragments
- `dotfiles/` — per-app config files (kitty, waybar, vim, etc.)
- `modules/` — reusable NixOS module fragments (`common.nix`, `linux.nix`, `darwin.nix`, `services.nix`)
- `users/` — per-user Home Manager home.nix files (`mathewelhans`, `guest`, `macUser`, `nixos`)
- `secrets/` — encrypted secrets (agenix); do NOT commit private keys

## Secrets (agenix)
This repo uses `agenix` for secrets. Do not commit private keys. Basic commands:

- Generate key:
```bash
# Create a new age key
age-keygen -o key.txt
```

- Encrypt a secret:
```bash
# Encrypt example.secret to example.secret.age (requires recipients public key)
agenix encrypt -r "<recipient-id>" -i secrets/example.secret -o secrets/example.secret.age
```

- Decrypt (local):
```bash
agenix decrypt -i secrets/example.secret.age -o decrypted.secret
```

Add a `secrets/README.md` with exact project key IDs and steps (recommended).

## Contributing
- Open issues or PRs for improvements
- Run tests / linting (if any) before creating PR
- Add a short description of changes in PRs (follow Conventional Commits if you like)

## Troubleshooting
- "flake not found": ensure `nix` version supports flakes and run `export NIX_CONFIG="experimental-features = nix-command flakes"`
- Build failures often come from network or outdated flakes; try `nix flake update` or `rm -rf result`

## License
MIT — see `LICENSE`

## Contact
Maintainer:](#)
