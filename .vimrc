execute pathogen#infect()

set encoding=UTF-8
syntax on
set title
set t_Co=256
set background=dark
colorscheme paterscheme

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

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2
set noshowmode
