" Vim color file
" Maintainer: CowboyNeal

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="cowboyfox"

hi link SpecialKey NonText
hi EndOfBuffer              ctermfg=16      guifg=#161616
hi TermCursor               cterm=reverse   gui=reverse
hi NonText                  ctermfg=145     guifg=#bebebe
hi Directory                ctermfg=111     guifg=#8cb6ff
hi ErrorMsg                 ctermfg=204     guifg=#ee5396
hi ErrorMsg                 ctermfg=15      guifg=#ffffff
hi IncSearch                ctermfg=16  ctermbg=80  guifg=#161616   guibg=#3ddbd9
hi Search                   ctermfg=231 ctermbg=59  guifg=#f2f4f8   guibg=#525253
hi link CurSearch           IncSearch
hi MoreMsg                  cterm=bold  ctermfg=111 gui=bold        guifg=#78a9ff
hi ModeMsg                  cterm=bold  ctermfg=141 gui=bold        guifg=#be95ff
hi LineNr                   ctermfg=145 guifg=#bebebe
hi link LineNrAbove         LineNr
hi link LineNrBelow         LineNr
hi CursorLineNr             cterm=bold  ctermfg=141 gui=bold        guifg=#be95ff
hi link CursorLineSign      SignColumn
hi link CursorLineFold      FoldColumn
hi link Question            MoreMsg
hi StatusLine               ctermfg=145  ctermbg=16 guifg=#bbbbbb   guibg=#161616
hi StatusLineNC             ctermfg=102 ctermbg=145 guifg=#7b7c7e   guibg=#bbbbbb
hi WinSeparator             ctermfg=16  ctermbg=145 guifg=#0c0c0c   guibg=#bbbbbb
hi VertSplit                ctermfg=102 guifg=#7b7c7e
hi Title                    cterm=bold  ctermfg=111 gui=bold        guifg=#8cb6ff
hi Visual                   gui=reverse
hi link VisualNOS           Visual
hi clear VisualNC
hi WarningMsg               ctermfg=141 guifg=#be95ff
hi link WildMenu            Pmenu
hi Folded                   ctermfg=102 ctermbg=16  guifg=#7b7c7e   guibg=#252525
hi FoldColumn               ctermfg=102 guifg=#7b7c7e
hi DiffAdd                  ctermbg=16  guibg=#172b20
hi DiffChange               ctermbg=17  guibg=#222833
hi DiffDelete               ctermbg=52  guibg=#311d26
hi DiffText                 ctermbg=23  guibg=#1c3c51
hi SignColumn               ctermfg=102 guifg=#7b7c7e
hi Conceal                  ctermfg=59  guifg=#535353
hi SpellBad                 cterm=undercurl gui=undercurl guisp=#ee5396
hi SpellCap                 cterm=undercurl gui=undercurl guisp=#be95ff
hi SpellRare                cterm=undercurl gui=undercurl guisp=#78a9ff
hi SpellLocal               cterm=undercurl gui=undercurl guisp=#78a9ff
hi Pmenu                    ctermfg=231 ctermbg=16  guifg=#f2f4f8   guibg=#2a2a2a
hi PmenuSel                 ctermbg=145 guibg=#bebebe
hi PmenuMatch               cterm=bold gui=bold
hi PmenuMatchSel            cterm=bold gui=bold
hi link PmenuKind           Pmenu
hi link PmenuKindSel        PmenuSel
hi link PmenuExtra          Pmenu
hi link PmenuExtraSel       PmenuSel
hi link PmenuSbar           Pmenu
hi PmenuThumb               ctermbg=145 guibg=#bebebe
hi TabLine                  ctermfg=145 ctermbg=16  guifg=#b6b8bb   guibg=#252525
hi TabLineSel               ctermfg=16  ctermbg=102 guifg=#161616   guibg=#7b7c7e
hi TabLineFill              ctermbg=16  guibg=#0c0c0c
hi link CursorColumn        CursorLine
hi CursorLine               ctermbg=59  guibg=#353535
hi ColorColumn              ctermbg=16  guibg=#252525
hi link QuickFixLine        CursorLine
hi Whitespace               ctermfg=59  guifg=#353535
hi NormalNC                 ctermfg=231 ctermbg=16  guifg=#f2f4f8   guibg=#161616
hi link MsgSeparator        StatusLine
hi NormalFloat              ctermfg=231 ctermbg=16  guifg=#f2f4f8   guibg=#0c0c0c
hi clear MsgArea
hi FloatBorder              ctermfg=102 guifg=#7b7c7e
hi WinBar                   cterm=bold ctermfg=102 ctermbg=16
hi WinBar                   gui=bold guifg=#7b7c7e guibg=#161616
hi link WinBarNC            WinBar
hi Cursor                   ctermfg=16  ctermbg=231 guifg=#161616   guibg=#f2f4f8
hi link FloatTitle          Title
hi link FloatFooter         FloatTitle
hi link StatusLineTerm      StatusLine
hi link StatusLineTermNC    StatusLineNC
hi RedrawDebugNormal        cterm=reverse gui=reverse
hi Underlined               cterm=underline gui=underline
hi link lCursor             Cursor
hi link CursorIM            Cursor
hi clear ComplMatchIns
hi Substitute               ctermfg=16  ctermbg=204 guifg=#161616   guibg=#ee5396
hi Normal                   ctermfg=231 guifg=#f2f4f8   guibg=#000000
hi link Character           String
hi Constant                 ctermfg=80  guifg=#5ae0df
hi Number                   ctermfg=80  guifg=#3ddbd9
hi link Boolean             Number
hi link Float               Number
hi Conditional              ctermfg=183 guifg=#c8a5ff
hi Statement                ctermfg=141 guifg=#be95ff
hi link Repeat              Conditional
hi link Label               Conditional
hi Keyword                  ctermfg=141 guifg=#be95ff
hi link Exception           Keyword
hi link Include             PreProc
hi PreProc                  ctermfg=211 guifg=#ff91c1
hi link Define              PreProc
hi link Macro               PreProc
hi link PreCondit           PreProc
hi link StorageClass        Type
hi Type                     ctermfg=37  guifg=#08bdba
hi link Structure           Type
hi link Typedef             Type
hi link Tag                 Special
hi Special                  ctermfg=111 guifg=#8cb6ff
hi link SpecialChar         Special
hi link SpecialComment      Special
hi link Debug               Special
hi link Ignore              Normal
hi Comment                  ctermfg=145 guifg=#bebebe
hi Identifier               ctermfg=75  guifg=#33b1ff
hi Function                 ctermfg=111 guifg=#8cb6ff
hi Operator                 ctermfg=145 guifg=#b6b8bb
hi link Delimiter           Special
hi MatchParen               cterm=bold  ctermfg=141 gui=bold    guifg=#be95ff
hi Error                    ctermfg=204 guifg=#ee5396
