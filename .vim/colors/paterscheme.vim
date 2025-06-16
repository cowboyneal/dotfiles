" Vim color file
" Maintainer: CowboyNeal

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="paterscheme"

hi Normal       cterm=none  gui=none    guifg=#bebebe   guibg=#000000
hi Cursor       ctermfg=0   ctermbg=15  guifg=#000000   guibg=#ffffff
hi lCursor      ctermfg=0   ctermbg=15  guifg=#ffffff   guibg=#000000
hi link CursorIM    Cursor
hi CursorLine   gui=none    guibg=#303030
hi CursorLineNR gui=none    guifg=#ffffff   guibg=#303030
hi Directory    ctermfg=14  guifg=#00ffff
hi DiffAdd      ctermfg=11  ctermbg=18  guifg=#ffff00   guibg=#000087
hi DiffDelete	ctermfg=238 guifg=#444444   guibg=#080808
hi DiffChange	guifg=#ffffff   guibg=#080808
hi DiffText     ctermfg=124 guifg=#af0000   guibg=#080808
hi ErrorMsg	    ctermfg=15  ctermbg=1   guifg=#ffffff   guibg=#800000
hi Folded       ctermfg=18  guifg=#000087   guibg=#000000
hi link FoldColumn  Folded
hi IncSearch	ctermfg=250 guifg=#bcbcbc   guibg=#000000
hi LineNr       cterm=none  ctermfg=8   guifg=#808080
hi ModeMsg      ctermfg=15  guifg=#ffffff
hi MoreMsg      ctermfg=83  guifg=#5fff5f
hi NonText      ctermfg=63  guifg=#5f5fff
hi Question     ctermfg=11  guifg=#ffff00
hi Search       ctermfg=83  ctermbg=NONE    guifg=#5fff5f guibg=NONE
hi SpecialKey   ctermfg=63  guifg=#5f5fff
hi Title        ctermfg=15  guifg=#ffffff

hi StatusLine   cterm=none  ctermfg=0   ctermbg=6
hi StatusLine   gui=none    guifg=#000000   guibg=#ffffff

hi StatusLineNC	cterm=none  ctermfg=0   ctermbg=7
hi StatusLineNC gui=none    guifg=#000000   guibg=#bcbcbc

hi VertSplit    cterm=none  ctermfg=0   ctermbg=7
hi VertSplit    gui=none    guibg=#bcbcbc   guifg=#000000

hi Visual       cterm=none  ctermfg=0   ctermbg=7
hi Visual       gui=none    guibg=#bcbcbc   guifg=#000000

hi link VisualNOS   Visual
hi WarningMsg   ctermfg=11  guifg=#ffff00
hi WildMenu     gui=none    guifg=#000000   guibg=#00afaf
" syntax highlighting groups
hi Comment      ctermfg=63  guifg=#5f5fff
hi Constant     ctermfg=44  guifg=#00d7d7
hi Identifier   ctermfg=15  gui=bold    guifg=#ffffff
hi Statement    cterm=bold  ctermfg=14  guifg=#00ffff
hi PreProc      ctermfg=44  guifg=#00d7d7
hi Type         cterm=bold ctermfg=254 gui=bold guifg=#e5e5e5
hi Special      cterm=bold  ctermfg=63  gui=bold    guifg=#5f5fff
hi Underlined	ctermfg=63  guifg=#5f5fff
hi Ignore       ctermfg=238 guifg=#444444
hi Error        ctermfg=160 guibg=#000000	guifg=#d70000
hi Todo         ctermfg=11	ctermbg=160 guifg=#ffff00   guibg=#d70000

hi link Character       Constant
hi link Number          Constant
hi link Boolean         Constant
hi link Float           Number
hi link Conditional     Statement
hi link Label           Statement
hi link Keyword         Statement
hi link Exception       Statement
hi link Repeat          Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link Delimiter       Special
hi link SpecialComment  Special
hi link Debug           Special
hi link FoldColumn      Folded

hi link Pmenu           StatusLineNC
hi link PmenuSel        StatusLine
hi link PmenuThumb      StatusLine
hi link PmenuSbar       StatusLineNC

hi SpellBad     ctermfg=9   ctermbg=none    gui=undercurl   guisp=#ff6666
hi SpellCap     ctermfg=12  ctermbg=none    gui=undercurl   guisp=#6666ff
hi SpellRare    ctermfg=13  ctermbg=none    gui=undercurl   guisp=#ff66ff

hi TabLine      cterm=inverse   ctermfg=none    ctermbg=none
hi TabLine      gui=none        guifg=#000000   guibg=#bcbcbc

hi TabLineSel   cterm=bold  ctermfg=none    ctermbg=none
hi TabLineSel   gui=none    guifg=#000000   guibg=#bcbcbc

hi TabLineFill 	cterm=inverse   ctermfg=none    ctermbg=none
hi TabLineFill  gui=none    guifg=#000000   guibg=#bcbcbc

hi MatchParen   term=reverse    ctermbg=6  guibg=#008080
