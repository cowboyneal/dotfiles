execute pathogen#infect()

set encoding=UTF-8
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
python3 << EOF
import sys, os, glob
prefix = os.path.expanduser('~/.python3')
for sp in glob.glob(os.path.join(prefix, 'lib', 'python3.*', 'site-packages')):
    if sp not in sys.path:
        sys.path.append(sp)
try:
    from powerline.vim import setup as powerline_setup
    powerline_setup()
    del powerline_setup
except ImportError:
    pass
EOF
    set noshowmode
endif

set laststatus=2
