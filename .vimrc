execute pathogen#infect()

let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'tokyonight'
let g:airline_powerline_fonts = 1
set termguicolors
set encoding=UTF-8

" Use semi-circles for main sections (Corrected Outer Direction)
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Use semi-circles for inner/sub sections (Corrected Inner Direction)
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''

syntax on
set title
set background=dark
colorscheme paterscheme
set t_Co=256

set number
set ruler
set fillchars=vert:\ 

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set textwidth=0

set nobackup
set nowritebackup
set noswapfile

set nocompatible
filetype plugin indent on

set wildmode=longest:full
set wildmenu

map <C-J> gqap
map <C-R> :r ~/doc/

if &l:term !=? "vt100" && &l:term !=? "vt220" && &l:term !=? "linux"
    set noshowmode
endif

set laststatus=2

highlight Normal ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
