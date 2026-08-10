# Betmut's NixOS Config

This is my personal NixOS (Flakes) configurations. The default window Manager is Hyprland.

![Alt Text](screenshots/screenshot-4.png)
![Alt Text](screenshots/screenshot-1.png)
![Alt Text](screenshots/screenshot-3.png)

## Features
- Strong modularity and reuse linux and services modules (you can even expand it into headless server configurations!)
- Cross-platform support that spans Linux desktop and macOS (using [nix-darwin](https://github.com/nix-darwin/nix-darwin) with Homebrew)
- Includes prebuilt outputs for install-ISO, VirtualBox, per-user Home Manager configs and Darwin system.
- Add [Lix](https://lix.systems/) as replacement of Nix package manager to fix technical debt (improved evaluation speeds for example) and improve readibility of error messages
- Add a wallpaper changer script to Change your wallpaper based on the time of day by pressing `SUPER+SHIFT+W` by default (you can actually change the keybinding as you wish)

## Default Environment details
| Type            | Name                                                                            | 
| :--------       | :--------:                                                                      |
| Window Manager  | [Hyprland](https://github.com/hyprwm/hyprland)                                  |
| Status bar      | [Waybar](https://github.com/Alexays/Waybar)                                     |
| Color Theme     | [Gruvbox Dark](https://gruvbox.org/)                                            |
| Kernel          | [XanMod](https://xanmod.org/)                                                   |
| Launcher        | [rofi](https://github.com/davatorium/rofi)                                      |
| Terminal        | [Kitty](https://sw.kovidgoyal.net/kitty)                                        |
| Shell           | [zsh](https://zsh.sourceforge.io/)                                              |
| Editor          | [VSCode](https://code.visualstudio.com/) - [vim](https://github.com/vim/vim)    |
| File Manager    | [Thunar](https://github.com/neilbrown/thunar)                                   |
| Notifications   | [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)                  |
| Wallpapers      | [awww](https://codeberg.org/LGFae/awww) - [waypaper](https://github.com/anufrievroman/waypaper)   |
| Terminal Font   | [Hasklug Nerd Font Mono](https://www.programmingfonts.org/#hasklig)             |


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
│   └── minimal-iso-config.nix      # Non-GUI custom ISO configurations (Including wl module for proprietary 
│                                     Broadcom driver support, NTFS/APFS support) 
│ 
├── modules/
│   ├── linux                       # 13+ focused modules (boot, docker, hardware, kernel, networking, 
│   │                                 display-manager, gaming, security, fonts, users, etc.)
│   │
│   ├── packages                    # Custom packages that fetch directly from the source code 
│   │                                 (waybar-git, zscroll, etc.)
│   │
│   └── services                    # Desktop services (SSH, media, location, torrent, 
│                                     RStudio server)
│
├── platforms/
│   ├── darwin                      # macOS (nix-darwin) system-level configurations
│   │
│   └── desktop                     # Linux desktop system-level configurations
│
├── hostname/                       # Hostname (linux, mac)
├── nix-settings.nix                # Nix daemon settings
├── disks.nix                       # Disk/filesystem configuration    
├── flake.nix                       # Entry point: defines outputs and flake composition
├── secrets                         # agenix-encrypted secrets
└── stylix.nix                      # Theme / styling (colors, fonts applied system-wide)
```


## Getting Started

### 1. Clone the repo
```
cd ~
git clone https://github.com/betmut/betmut-nixos-config.git
cd ~/betmut-nixos-config
```

### 2. Build the ISO
Download the [Nix package manager](https://nixos.org/download/) and ISO installer from the [official NixOS Website](https://nixos.org/download/) or build the custom ISO file by running
```
#if you clone the repo
nix build .#packages.x86_64-linux.minimal-iso

#if you run the flakes directly without cloning
nix build github:betmut/betmut-nixos-config#packages.x86_64-linux.minimal-iso
```

### 3. Rebuild the system configuration (NixOS)
```
sudo nixos-rebuild switch --flake .#<hostname>
```

### 4. Rebuild the system configuration (MacOS)
Install [Nix-Darwin](https://github.com/nix-darwin/nix-darwin) and follow the installation instruction, and then, run this command:
```
darwin-rebuild switch --flake .#<mac-hostname>
```

## License
MIT — see `LICENSE`
