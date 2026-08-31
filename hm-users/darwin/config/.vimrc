set nocompatible              " be iMproved, required
            filetype off                  " required

            " set the runtime path to include Vundle and initialize
            set rtp+=~/.vim/bundle/Vundle.vim

            call vundle#begin()
            " alternatively, pass a path where Vundle should install plugins

            "call vundle#begin('~/some/path/here')
            " let Vundle manage Vundle, required
            Plugin 'VundleVim/Vundle.vim'" All of your Plugins must be added before the following line
            Plugin 'lambdalisue/battery.vim'

            call vundle#end()            " required

            filetype plugin indent on    " required
            " To ignore plugin indent changes, instead use:
            "filetype plugin on
            "
            " Brief help
            " :PluginList       - lists configured plugins
            " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
            " :PluginSearch foo - searches for foo; append `!` to refresh local cache
            " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
            "
            " see :h vundle for more details or wiki for FAQ
            " Put your non-Plugin stuff after this line


			syntax on 
			set t_Co=256
			set cursorline
			set timeoutlen=500     " For mapped sequences (normal mode)
			set ttimeout           " Enable timeout for key codes (insert mode)
			set ttimeoutlen=10     " Lower = faster escape from Insert mode
            set termguicolors
            set clipboard=unnamedplus
			colorscheme gruvbox
            "colorscheme desert


            let g:airline_extensions = ['tabline', 'battery', "clock"]

            " tabline format
            let g:airline#extensions#tabline#formatter = 'unique_tail'

            " Enable powerline fonts
            let g:airline_powerline_fonts = 1

            " clock format
            let g:airline#extensions#clock#format = ' %H:%M'
            let g:airline#extensions#clock#auto = 0

            " vim-slime target
            let g:slime_target = "tmux"

            function! AirlineInit()
                let g:airline_section_a = airline#section#create(['mode'])
                let g:airline_section_b = airline#section#create_left(['battery','clock'])
            endfunction
            autocmd User AirlineAfterInit call AirlineInit()

            "keymapping
            inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"