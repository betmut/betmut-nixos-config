# NixOS-custom-iso

This is my personal NixOS (Flakes) configurations. The default window Manager is Hyprland.

![Alt Text](screenshots/screenshot-1.png)
![Alt Text](screenshots/screenshot-2.png)
![Alt Text](screenshots/screenshot-3.png)

## Features
- Strong modularity and reuse linux and services modules (you can even expand it into headless server configurations!)
- Cross-platform support that spans Linux desktop and macOS (using nix-darwin with Homebrew)
- Includes prebuilt outputs for install-ISO, VirtualBox, per-user Home Manager configs and Darwin system.

## File Structures
```
.
├── desktop-environment/            # Hyprland-specific config (hyprland.lua, conf/ fragments)
│   └── hyprland
│
├── hm-users/                       # User-level configurations managed by Home Manager
│   ├── guest
│   ├── macUser
│   ├── mathewelhans
│   └── nixos
│
├── iso-configurations/             # Custom ISO build configurations
│   └── minimal-iso-config.nix      # Non-graphical custom ISO configurations 
│ 
├── modules/
│   ├── linux                       # 13 focused modules (boot, hardware, kernel, networking, 
│   │                               # display-manager, gaming, security, fonts, users, etc.)
│   │
│   ├── packages                    # Custom package overlays (waybar-git, zscroll, etc.)
│   │
│   └── services                    # Desktop services (SSH, media, location, torrent, RStudio)
│
├── platforms/
│   ├── darwin                      # macOS (nix-darwin) configurations
│   │
│   └── desktop                     # Linux desktop configurations
│
├── hostname/                       # Hostname (linux, mac)
├── nix-settings.nix                # Nix daemon settings
├── disks.nix                       # Disk/filesystem configuration    
├── flake.nix                       # Entry point: defines outputs and flake composition
├── secrets                         # agenix-encrypted secrets
└── stylix.nix                      # Theme / styling (colors, fonts applied system-wide)
```


## Getting Started
you can run 

## License
MIT — see `LICENSE`