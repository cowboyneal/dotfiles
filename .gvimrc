colorscheme default
highlight Normal guifg=grey75 guibg=black
highlight LineNr guibg=grey75 guifg=black
set guifont=Fixed\ Medium\ Semi-Condensed\ 9.5

hi Pmenu ctermbg=darkgray ctermfg=gray guibg=darkgray guifg=black
hi PmenuSel ctermbg=gray ctermfg=black guibg=black guifg=grey75
hi PmenuSbar ctermbg=gray guibg=black
hi PmenuThumb cterm=reverse gui=reverse

"set lines=82 columns=116
set lines=82 columns=160

set number
set ruler
set laststatus=2
set showmatch
set showmode
set fillchars=vert:\ 
set visualbell

autocmd vimenter * NERDTree /home/$USER
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
