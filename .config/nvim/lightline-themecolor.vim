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

let s:black_gui    = "#000000"
let s:white_gui    = "#cbba98"
let s:gray1_gui    = "#a99887"
let s:gray2_gui    = "#767056"
let s:gray3_gui    = "#48403a"
let s:gray4_gui    = "#2c2824"
let s:red_gui      = "#cc6644"
let s:green_gui    = "#81a621"
let s:yellow_gui   = "#ddaa66"
let s:magenta_gui  = "#9f7f9f"
let s:blue_gui     = "#80a0ff"
let s:cyan_gui     = "#a0aaaf"

let s:black   = [s:black_gui  , s:rgb_to_256(s:black_gui)  ]
let s:white   = [s:white_gui  , s:rgb_to_256(s:white_gui)  ]
let s:gray1   = [s:gray1_gui  , s:rgb_to_256(s:gray1_gui)  ]
let s:gray2   = [s:gray2_gui  , s:rgb_to_256(s:gray2_gui)  ]
let s:gray3   = [s:gray3_gui  , 240                        ]
let s:gray4   = [s:gray4_gui  , 235                        ]
let s:red     = [s:red_gui    , s:rgb_to_256(s:red_gui)    ]
let s:green   = [s:green_gui  , s:rgb_to_256(s:green_gui)  ]
let s:yellow  = [s:yellow_gui , s:rgb_to_256(s:yellow_gui) ]
let s:magenta = [s:magenta_gui, s:rgb_to_256(s:magenta_gui)]
let s:blue    = [s:blue_gui   , s:rgb_to_256(s:blue_gui)   ]
let s:cyan    = [s:cyan_gui   , s:rgb_to_256(s:cyan_gui)   ]
" }}}

" set lightline.vim's palette {{{
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [[s:black, s:cyan]    , [s:white, s:gray3]]
let s:p.normal.middle   = [[s:white, s:gray4]]
let s:p.normal.right    = [[s:gray2, s:gray4]    , [s:gray2, s:gray4]]
let s:p.inactive.left   = [[s:gray1, s:gray4]   , [s:gray1, s:gray4]]
let s:p.inactive.middle = [[s:black, s:gray4]]
let s:p.inactive.right  = [[s:gray1, s:gray4]   , [s:gray1, s:gray4]]
let s:p.insert.left     = [[s:black, s:green]   , [s:white, s:gray3]]
let s:p.insert.right    = [[s:gray2, s:gray4]    , [s:gray2, s:gray4]]
let s:p.replace.left    = [[s:black, s:yellow]  , [s:white, s:gray3]]
let s:p.replace.right   = [[s:gray2, s:gray4]    , [s:gray2, s:gray4]]
let s:p.visual.left     = [[s:white, s:magenta] , [s:white, s:gray3]]
let s:p.visual.right    = [[s:gray2, s:gray4]    , [s:gray2, s:gray4]]
let s:p.tabline.left    = [[s:white, s:black]]
let s:p.tabline.tabsel  = [[s:white, s:gray3]]
let s:p.tabline.middle  = [[s:white, s:gray4]]
let s:p.tabline.right   = [[s:black, s:gray1]]
let s:p.normal.warning  = [[s:white, s:red]]
let s:p.normal.error    = [[s:white, s:red]]
" }}}

" exports palette {{{
let g:lightline#colorscheme#themecolor#palette = lightline#colorscheme#flatten(s:p)
" }}}

" plugin's convention (end) {{{
let &cpo = s:save_cpo
" }}}

" vim: fdm=marker
