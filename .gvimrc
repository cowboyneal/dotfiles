colorscheme paterscheme
"set guifont=Fixed\ Medium\ Semi-Condensed\ 9.5
set guifont=DejaVu\ Sans\ Mono\ 10

map <C-S-X> "+x
map <C-S-C> "+y
map <C-S-V> "+gP
map! <C-S-V> <C-O>"+gP

set lines=50 columns=112
"set lines=83 columns=168

set laststatus=2
set showmatch
set visualbell
set cursorline
set guicursor+=a:blinkon0
let g:NERDTreeWinSize=26

autocmd GUIEnter * winpos 688 75
autocmd vimenter * NERDTree /home/$USER
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
