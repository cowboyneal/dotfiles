" Vim color file
" Maintainer: CowboyNeal

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="paterscheme"

hi Normal	cterm=none		gui=none	guibg=#000000	guifg=#b0b0b0
hi Cursor	guifg=#000000 guibg=#ffffff ctermfg=black ctermbg=white
hi lCursor	guifg=#ffffff guibg=#000000 ctermfg=black ctermbg=white
hi link CursorIM Cursor
hi CursorLine gui=none guibg=#404040
hi CursorLineNR gui=none guibg=#404040 guifg=#ffffff
hi Directory	ctermfg=cyan    guifg=#00ffff
hi DiffAdd	ctermbg=blue	ctermfg=yellow	guibg=#080888	guifg=#ffff00
hi DiffDelete	ctermbg=black	ctermfg=darkgray	guibg=#080808	guifg=#444444
hi DiffChange	ctermbg=black	guibg=#080808	guifg=#ffffff
hi DiffText	ctermbg=black	ctermfg=darkred	guibg=#080808	guifg=#bb0000
hi ErrorMsg	ctermbg=darkred	ctermfg=white	guibg=#880000	guifg=#ffffff
hi Folded	ctermbg=black	ctermfg=darkblue	guibg=black	guifg=#000088
hi link FoldColumn Folded
hi IncSearch	ctermbg=black	ctermfg=gray	guibg=#000000	guifg=#bbcccc
hi LineNr guifg=#808080 ctermfg=gray cterm=none
hi ModeMsg				ctermfg=white				guifg=#ffffff
hi MoreMsg				ctermfg=green				guifg=#44ff44
hi NonText				ctermfg=blue				guifg=#4444ff
hi Question				ctermfg=yellow				guifg=#ffff00
hi Search	ctermbg=NONE		ctermfg=green		guibg=NONE	guifg=green
hi SpecialKey				ctermfg=blue				guifg=#4444ff
hi StatusLine cterm=none ctermbg=darkcyan ctermfg=black gui=none guibg=#ffffff guifg=#000000
hi StatusLineNC	cterm=none ctermbg=gray	ctermfg=black gui=none guibg=#bbbbbb guifg=#000000
hi VertSplit cterm=none ctermbg=gray ctermfg=black gui=none guibg=#bbbbbb guifg=#000000
hi Title				ctermfg=white				guifg=#ffffff
hi Visual	cterm=none ctermbg=gray		ctermfg=black	gui=none	guibg=#bbbbbb	guifg=#000000
hi link VisualNOS Visual
hi WarningMsg				ctermfg=yellow				guifg=#ffff00
hi WildMenu	gui=none guifg=#000000 guibg=#00aaaa
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
hi Comment	ctermfg=blue guifg=#5c5cff
hi Constant	ctermfg=darkcyan		guifg=#00cdcd
hi Identifier ctermfg=white gui=bold guifg=#ffffff
hi Statement cterm=bold ctermfg=cyan guifg=#00ffff
hi PreProc	ctermfg=darkcyan	guifg=#00cdcd
hi Type		ctermfg=white	guifg=#e5e5e5
hi Special	ctermfg=blue	cterm=bold	guifg=#5c5cff	gui=bold
hi Underlined	ctermfg=blue	guifg=#5c5cff
hi Ignore	ctermfg=darkgray	guifg=#444444
hi Error	ctermbg=black	ctermfg=darkred	guibg=#000000	guifg=#cd0000
hi Todo		ctermbg=darkred	ctermfg=yellow	guibg=#cd0000	guifg=#ffff00

hi link Character	Constant
hi link Number		Constant
hi link Boolean		Constant
hi link Float		Number
hi link Conditional	Statement
hi link Label		Statement
hi link Keyword		Statement
hi link Exception	Statement
hi link Repeat		Statement
hi link Include		PreProc
hi link Define		PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef		Type
hi link Tag		Special
hi link Delimiter	Special
hi link SpecialComment	Special
hi link Debug		Special
hi link FoldColumn	Folded

if v:version >= 700
	hi link Pmenu		StatusLineNC
	hi link PmenuSel	StatusLine
	hi link PmenuThumb	StatusLine
	hi link PmenuSbar	StatusLineNC

	hi SpellBad	ctermbg=none	ctermfg=red	gui=undercurl	guisp=#ff6666
	hi SpellCap	ctermbg=none	ctermfg=blue	gui=undercurl	guisp=#6666ff
	hi SpellRare	ctermbg=none	ctermfg=magenta	gui=undercurl	guisp=#ff66ff

	hi TabLine cterm=inverse ctermbg=none ctermfg=none gui=none	guibg=#bbbbbb guifg=#000000
	hi TabLineSel cterm=bold ctermbg=none ctermfg=none gui=none	guibg=#bbbbbb guifg=#000000
	hi TabLineFill 	cterm=inverse	ctermbg=none	ctermfg=none	gui=none	guibg=#bbbbbb	guifg=#000000

	hi MatchParen	cterm=bold	ctermbg=none	ctermfg=magenta gui=bold	guibg=bg	guifg=#ff00ff
endif
