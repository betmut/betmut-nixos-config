{pkgs, lib, ... }: {
  home.stateVersion = "25.11";
  
  #Packages
  home.packages = with pkgs; [nodejs python3 R gemini-cli htop cmatrix];
  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };
  
  #VIM config
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; 
      [
        vim-fugitive
        vim-airline
        vim-airline-themes
        vim-airline-clock
        vim-slime
        vim-racket
        gruvbox
        nerdtree
        coc-nvim
        Vundle-vim

        #coc plugins
        coc-pyright #python lsp
        coc-sh
      ];
    settings = {
      background = "dark";
      expandtab = true;
      number = true;
      shiftwidth = 4;
      tabstop = 4;
      mouse = "v";
    };
    extraConfig = builtins.readFile ../../dotfiles/vim/.vimrc;
	};

  #zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "battery"];
      theme = "xiong-chiamiov-plus";
    };
    
    initContent = 
    let
      zshRPROMPT = lib.mkOrder 1000 (builtins.readFile ../../dotfiles/shell/custom_prompt.sh);
    in
      lib.mkMerge [zshRPROMPT];
    #Content to be added to {file}`.zshrc`.

    #To specify the order, use `lib.mkOrder`.

    #Common order values:
    #- 500 (mkBefore): Early initialization (replaces initExtraFirst)
    #- 550: Before completion initialization (replaces initExtraBeforeCompInit)
    #- 1000 (default): General configuration (replaces initExtra)
    #- 1500 (mkAfter): Last to run configuration

    #To specify both content in Early initialization and General configuration, use `lib.mkMerge`.

    #e.g.

    #initContent = let
    #               zshConfigEarlyInit = lib.mkOrder 500 "do something";
    #               zshConfig = lib.mkOrder 1000 "do something";
    #              in
    #               lib.mkMerge [ zshConfigEarlyInit zshConfig ];
  };
}
