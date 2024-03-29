colorscheme paterscheme
"highlight Normal guifg=grey75 guibg=black
"highlight LineNr guibg=grey75 guifg=black
"set guifont=Fixed\ Medium\ Semi-Condensed\ 9.5
set guifont=DejaVu\ Sans\ Mono\ 9

"hi Pmenu ctermbg=darkgray ctermfg=gray guibg=darkgray guifg=black
"hi PmenuSel ctermbg=gray ctermfg=black guibg=black guifg=grey75
"hi PmenuSbar ctermbg=gray guibg=black
"hi PmenuThumb cterm=reverse gui=reverse

set lines=54 columns=116
"set lines=83 columns=168

set laststatus=2
set showmatch
"set showmode
"set number
"set ruler
"set fillchars=vert:\ 
set visualbell
set cursorline

autocmd vimenter * NERDTree /home/$USER
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
