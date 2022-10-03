:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a


"#==~~~~~ Plugins ~~~~~==#"

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
"Place Plugins Here"
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree' " Tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons' " Custom Icons
Plug 'vim-airline/vim-airline' " Status bar
Plug 'tpope/vim-surround' " Surrounding ysw
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'rafi/awesome-vim-colorschemes' " Color Schemes
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/tagbar' "Tagbar for code navigation
Plug 'neoclide/coc.nvim' " Auto completion
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fedepujol/move.nvim'
call plug#end()

"Start commands"
let g:startify_bookmarks = [
	\ {'z': '~/.zshrc'},
	\ ]

"NerdTree Config"
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "Auto Close NerdTree
" Move.nvim
nnoremap <silent> <A-j> :MoveLine(1)<CR>
nnoremap <silent> <A-k> :MoveLine(-1)<CR>
vnoremap <silent> <A-j> :MoveBlock(1)<CR>
vnoremap <silent> <A-k> :MoveBlock(-1)<CR>

nnoremap <silent> <A-l> :MoveHChar(1)<CR>
nnoremap <silent> <A-h> :MoveHChar(-1)<CR>
vnoremap <silent> <A-l> :MoveHBlock(1)<CR>
vnoremap <silent> <A-h> :MoveHBlock(-1)<CR>

"Tagbar Config"
nmap <F8> :TagbarToggle<CR>
"Color Scheme"
:colorscheme solarized8
"Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"Airline"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" air-line
let g:airline_powerline_fonts = 1
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

