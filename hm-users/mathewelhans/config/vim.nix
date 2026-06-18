{config, pkgs, lib, ...}: {

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
      mouse = "a";
    };
    extraConfig = builtins.readFile ../../../dotfiles/vim/.vimrc;
  };
}