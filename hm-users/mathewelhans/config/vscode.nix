{config, pkgs,...}:{
  stylix.targets.vscode.enable = false;
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; 
      [
        #syntax-higlighting, lsp
        jeff-hykin.better-nix-syntax
        ecmel.vscode-html-css
        davidanson.vscode-markdownlint
        ms-python.vscode-pylance     

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
       
      userSettings = {
        #window
        #"window.autoDetectColorScheme" = false;

        #workbench
        "workbench.startupEditor" = "none";
        "workbench.iconTheme" =  "vscode-icons";
        "workbench.colorTheme" = "Gruvbox Dark Hard";
      
        #editor
        "editor.fontSize" = 14;
        "editor.lineHeight" = 1.4;
        "editor.fontFamily" = "Hasklug Nerd Font";
        "editor.cursorBlinking" = "smooth";
        "editor.cursorStyle" = "line";
        "editor.fontLigatures" =  true; 
        "editor.tabSize" = 2;

        "[nix]" = {
          "editor.tabSize" = 2;      # Nix community standard is 2 spaces
        };
        "[python]" = {
          "editor.tabSize" = 4;      # Standard for PEP 8
        };
        "[javascript]" = {
          "editor.tabSize" = 2;
        };
      };
    };
  };
}