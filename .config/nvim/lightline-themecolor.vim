if exists('g:loaded_themecolor_lightline')
    finish
endif
let g:loaded_themecolor_lightline = 1

let s:save_cpo = &cpo
set cpo&vim
" }}}

" set color variables {{{
function! s:rgb_to_256(color)
    let l:r = str2nr(a:color[1:2], 16) * 6 / 256
    let l:g = str2nr(a:color[3:4], 16) * 6 / 256
    let l:b = str2nr(a:color[5:6], 16) * 6 / 256

    return l:r * 36 + l:g * 6 + l:b + 16
endfunction

" get highlight color
function! s:getHighlightColor(group)
  let guiColorFg = synIDattr(hlID(a:group), "fg", "gui")
  let guiColorBg = synIDattr(hlID(a:group), "bg", "gui")
  let termColorFg = s:rgb_to_256(guiColorFg)
  let termColorBg = s:rgb_to_256(guiColorBg)
  return [ [ guiColorFg, termColorFg ], [ guiColorBg, termColorBg ] ]
endfunction

function! s:getHighlightReverseColor(group)
  let guiColorFg = synIDattr(hlID(a:group), "fg", "gui")
  let guiColorBg = synIDattr(hlID(a:group), "bg", "gui")
  let termColorFg = s:rgb_to_256(guiColorFg)
  let termColorBg = s:rgb_to_256(guiColorBg)
  return [ [ guiColorBg, termColorBg ], [ guiColorFg, termColorFg ] ]
endfunction

function! s:getHighlightFgColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui")
  let termColor = s:rgb_to_256(guiColor)
  return [ guiColor, termColor ]
endfunction

function! s:getHighlightBgColor(group)
  let guiColor = synIDattr(hlID(a:group), "bg", "gui")
  let termColor = s:rgb_to_256(guiColor)
  return [ guiColor, termColor ]
endfunction

let s:normal_guibg  = "#6e88a6"
let s:insert_guibg  = "#87af87"
let s:visual_guibg  = "#875faf"
let s:replace_guibg = "#ff875f"

let s:normal_bgcolor      = [s:normal_guibg  , s:rgb_to_256(s:normal_guibg)  ]
let s:insert_bgcolor      = [s:insert_guibg  , s:rgb_to_256(s:insert_guibg)  ]
let s:visual_bgcolor      = [s:visual_guibg  , s:rgb_to_256(s:visual_guibg)  ]
let s:replace_bgcolor     = [s:replace_guibg  , s:rgb_to_256(s:replace_guibg)  ]
" }}}

" set lightline.vim's palette {{{
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [[s:getHighlightFgColor("StatusLine"), s:normal_bgcolor]    , s:getHighlightColor("StatusLine")]
let s:p.normal.middle   = [s:getHighlightColor("StatusLineNC")]
let s:p.normal.right    = [s:getHighlightReverseColor("StatusLine")    , s:getHighlightReverseColor("StatusLine")]
let s:p.inactive.left   = [s:getHighlightColor("StatusLineNC")   , s:getHighlightColor("StatusLineNC")]
let s:p.inactive.middle = [s:getHighlightColor("StatusLineNC")]
let s:p.inactive.right  = [s:getHighlightColor("StatusLineNC")   , s:getHighlightColor("StatusLineNC")]
let s:p.insert.left     = [[s:getHighlightFgColor("StatusLine"), s:insert_bgcolor]    , s:getHighlightColor("StatusLine")]
let s:p.insert.right    = [s:getHighlightReverseColor("StatusLine")    , s:getHighlightReverseColor("StatusLine")]
let s:p.replace.left    = [[s:getHighlightFgColor("StatusLine"), s:replace_bgcolor]    , s:getHighlightColor("StatusLine")]
let s:p.replace.right   = [s:getHighlightReverseColor("StatusLine")    , s:getHighlightReverseColor("StatusLine")]
let s:p.visual.left     = [[s:getHighlightFgColor("StatusLine"), s:visual_bgcolor]    , s:getHighlightColor("StatusLine")]
let s:p.visual.right    = [s:getHighlightReverseColor("StatusLine")    , s:getHighlightReverseColor("StatusLine")]
let s:p.tabline.left    = [s:getHighlightColor("TabLine")]
let s:p.tabline.tabsel  = [s:getHighlightColor("TabLineSel")]
let s:p.tabline.middle  = [s:getHighlightColor("TabLineFill")]
let s:p.tabline.right   = [s:getHighlightReverseColor("TabLine")]
let s:p.normal.warning  = [s:getHighlightColor("WarningMsg")]
let s:p.normal.error    = [s:getHighlightColor("ErrorMsg")]
" }}}

" exports palette {{{
let g:lightline#colorscheme#themecolor#palette = lightline#colorscheme#flatten(s:p)
" }}}

" plugin's convention (end) {{{
let &cpo = s:save_cpo
" }}}

" vim: fdm=marker
