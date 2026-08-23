{config, pkgs, modulesPath, ... }: {

  imports = [
    ./minimal-iso-config.nix
    (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix")
  ];

  #VSCode configuration
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      #syntax-higlighting, lsp
      jeff-hykin.better-nix-syntax
      ecmel.vscode-html-css
      davidanson.vscode-markdownlint
      ms-python.vscode-pylance
      leanprover.lean4
      tamasfe.even-better-toml     

      #colorscheme
      jdinhlife.gruvbox
      vscode-icons-team.vscode-icons
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "magic-racket";
        publisher = "evzen-wybitul"; 
        version = "0.8.0";
        sha256 = "yWmJFLXktsJDEDwHO8ZCXQBTw8j5bOv6TXEOO/V8mZs=";
      }
    ];
  };
}