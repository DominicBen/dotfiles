call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
"Place Plugins Here"
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'


"Start commands"
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
call plug#end()

