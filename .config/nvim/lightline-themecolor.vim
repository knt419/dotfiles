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
    if synIDattr(hlID(a:group), "reverse") == 1
        let guiColorFg = synIDattr(hlID(a:group), "bg", "gui")
        let guiColorBg = synIDattr(hlID(a:group), "fg", "gui")
        let termColorFg = s:rgb_to_256(guiColorFg)
        let termColorBg = s:rgb_to_256(guiColorBg)
    else
        let guiColorFg = synIDattr(hlID(a:group), "fg", "gui")
        let guiColorBg = synIDattr(hlID(a:group), "bg", "gui")
        let termColorFg = s:rgb_to_256(guiColorFg)
        let termColorBg = s:rgb_to_256(guiColorBg)
    endif
    return [ [ guiColorFg, termColorFg ], [ guiColorBg, termColorBg ] ]
endfunction

function! s:getHighlightReverseColor(group)
    if synIDattr(hlID(a:group), "reverse") == 1
        let guiColorFg = synIDattr(hlID(a:group), "bg", "gui")
        let guiColorBg = synIDattr(hlID(a:group), "fg", "gui")
        let termColorFg = s:rgb_to_256(guiColorFg)
        let termColorBg = s:rgb_to_256(guiColorBg)
    else
        let guiColorFg = synIDattr(hlID(a:group), "fg", "gui")
        let guiColorBg = synIDattr(hlID(a:group), "bg", "gui")
        let termColorFg = s:rgb_to_256(guiColorFg)
        let termColorBg = s:rgb_to_256(guiColorBg)
    endif
    return [ [ guiColorBg, termColorBg ], [ guiColorFg, termColorFg ] ]
endfunction

" set lightline.vim's palette {{{
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [s:getHighlightColor("StatusLine")    , s:getHighlightColor("StatusLine")]
let s:p.normal.middle   = [s:getHighlightColor("StatusLineNC")]
let s:p.normal.right    = [s:getHighlightReverseColor("StatusLine")    , s:getHighlightReverseColor("StatusLine")]
let s:p.inactive.left   = [s:getHighlightColor("StatusLineNC")   , s:getHighlightColor("StatusLineNC")]
let s:p.inactive.middle = [s:getHighlightColor("StatusLineNC")]
let s:p.inactive.right  = [s:getHighlightColor("StatusLineNC")   , s:getHighlightColor("StatusLineNC")]
let s:p.insert.left     = [s:getHighlightColor("DiffAdd")   , s:getHighlightColor("StatusLine")]
let s:p.insert.right    = [s:getHighlightReverseColor("StatusLine")    , s:getHighlightReverseColor("StatusLine")]
let s:p.replace.left    = [s:getHighlightColor("DiffChange")   , s:getHighlightColor("StatusLine")]
let s:p.replace.right   = [s:getHighlightReverseColor("StatusLine")    , s:getHighlightReverseColor("StatusLine")]
let s:p.visual.left     = [s:getHighlightColor("DiffText")    , s:getHighlightColor("StatusLine")]
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
