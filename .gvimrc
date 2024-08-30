colorscheme paterscheme
"set guifont=Fixed\ Medium\ Semi-Condensed\ 9.5
set guifont=DejaVu\ Sans\ Mono\ 9

map <C-S-X> "+x
map <C-S-C> "+y
map <C-S-V> "+gP
map! <C-S-V> <C-O>"+gP

set lines=54 columns=116
"set lines=83 columns=168

set laststatus=2
set showmatch
set visualbell
set cursorline

autocmd vimenter * NERDTree /home/$USER
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
