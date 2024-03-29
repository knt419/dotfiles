" gui elements
let g:tab_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gnvim')
let g:statusline_gui = exists('g:gui_oni') || exists('g:veonim')
let g:completion_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gnvim')
let g:cmdline_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gonvim_running') || exists('g:gnvim')

" plugin install

call minpac#init({'verbose': 3})
call minpac#add('k-takata/minpac', {'type': 'opt', 'branch': 'devel'})

" editor display
call minpac#add('lukas-reineke/indent-blankline.nvim')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('lilydjwg/colorizer')
call minpac#add('tweekmonster/startuptime.vim')
call minpac#add('mhinz/vim-startify')
call minpac#add('itchyny/lightline.vim')
call minpac#add('mengelbrecht/lightline-bufferline')
call minpac#add('ntpeters/vim-better-whitespace')
call minpac#add('rickhowe/diffchar.vim')
call minpac#add('romainl/vim-qf')
call minpac#add('TaDaa/vimade')
call minpac#add('andymass/vim-matchup')
if !exists('g:nvui')
    call minpac#add('camspiers/animate.vim')
    call minpac#add('camspiers/lens.vim')
endif
call minpac#add('itchyny/vim-cursorword')
call minpac#add('nvim-treesitter/nvim-treesitter')

" text/input manipulation
call minpac#add('cohama/lexima.vim')
call minpac#add('godlygeek/tabular')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('rhysd/accelerated-jk')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-sleuth')
call minpac#add('kana/vim-textobj-user')
call minpac#add('kana/vim-textobj-line')
call minpac#add('kana/vim-smartword')
call minpac#add('kana/vim-niceblock')
call minpac#add('haya14busa/vim-asterisk')
call minpac#add('terryma/vim-expand-region')
call minpac#add('wincent/ferret', {'type': 'opt', 'on': '<Plug>(FerretAck)'})
call minpac#add('kana/vim-operator-user')
call minpac#add('kana/vim-operator-replace')
call minpac#add('tyru/capture.vim', {'type': 'opt', 'on': 'Capture'})
call minpac#add('junegunn/vim-easy-align')

" file/directory
call minpac#add('januswel/fencja.vim')
call minpac#add('voldikss/vim-floaterm')

" git
call minpac#add('tpope/vim-fugitive')
call minpac#add('int3/vim-extradite')

" language support
call minpac#add('mechatroner/rainbow_csv')
call minpac#add('tpope/vim-dadbod')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('honza/vim-snippets')
call minpac#add('pechorin/any-jump.vim')

" colorscheme
call minpac#add('jeetsukumaran/vim-nefertiti', {'type': 'opt'})
call minpac#add('Nequo/vim-allomancer', {'type': 'opt'})
call minpac#add('ajmwagar/vim-deus', {'type': 'opt'})
call minpac#add('sainnhe/edge', {'type': 'opt'})
call minpac#add('tyrannicaltoucan/vim-quantum', {'type': 'opt'})
call minpac#add('tyrannicaltoucan/vim-deep-space')
call minpac#add('knt419/lightline-colorscheme-themecolor', {'type': 'opt'})

" lsp/completion
if !g:completion_gui
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
    set completeopt=noinsert,menuone,noselect,preview
    set shortmess+=c
endif

if exists('g:minpac_has_installed')
    call minpac#update()
endif

" plugin variables

lua <<EOF
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
        }
    }
require'nvim-treesitter.configs'.setup {
  matchup = {
    enable = true
  },
}
EOF

" tabline
if !g:tab_gui
    set showtabline=2
endif

" statusline
if g:statusline_gui
    set laststatus=0
endif

" cmdline
if g:cmdline_gui
    set cmdheight=1
endif

let g:lightline = {
            \ 'colorscheme': 'deepspace',
            \ 'active': {
            \    'left': [
            \      ['mode', 'paste'],
            \      ['cocstatus']
            \    ],
            \    'right': [
            \      ['readonly', 'changes', 'filetype', 'fileformat', 'fileencoding', 'lineinfo', 'percentage'],
            \    ]
            \ },
            \ 'tabline': {
            \   'left': [['winfo', 'buffers']],
            \   'right': [['repostatus','repository']]
            \ },
            \ 'component': {
            \   'lineinfo': "\ue0a1".'%3l:%3v',
            \   'percentage': '%2p%%',
            \ },
            \ 'component_visible_condition': {
            \   'lineinfo': '1'
            \ },
            \ 'component_function': {
            \    'readonly'   : 'LightlineReadonly',
            \    'repository': 'LightlineRepository',
            \    'repostatus': 'LightlineRepoStatus',
            \    'filetype'   : 'LightlineFiletype',
            \    'fileformat': 'LightlineFileformat',
            \    'changes'    : 'LightlineChanges',
            \    'cocstatus'  : 'coc#status',
            \    'winfo'      : 'LightlineWInfo'
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers',
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel',
            \ },
            \ 'mode_map': {
            \   'n': "\ufc44",
            \   'i': "\uf040",
            \   'R': "\uf954",
            \   'v': "\uf988",
            \   'V': "\uf988".'LINE',
            \   "\<C-v>": "\uf988".'BLOCK',
            \   'c': "\ufcb5",
            \   's': "\uf044",
            \   'S': "\uf044 ".'LINE',
            \   "\<C-s>": "\uf044 ".'BLOCK',
            \   't': "\uf68c",
            \ },
            \ 'enable': {
            \   'statusline': !g:statusline_gui,
            \   'tabline': !g:tab_gui
            \ },
            \ 'separator': {
            \   'left': "│",
            \   'right': "│"
            \ },
            \ 'subseparator': {
            \   'left': "│",
            \   'right': "│"
            \ },
            \ }

if winwidth(0) < 100
    let g:lightline#bufferline#filename_modifier = ':t'
endif

if g:is_windows
    let g:FerretNvim                = 0
    let g:FerretJob                 = 0
endif

let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1

let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-yaml',
            \ 'coc-lists', 'coc-snippets', 'coc-java',
            \ 'coc-prettier', 'coc-go', 'coc-vimlsp', 'coc-explorer']

let g:indentLine_bufTypeExclude = ['help', 'terminal']
let g:indentLine_fileTypeExclude = ['startify']
let g:lexima_ctrlh_as_backspace = 1
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'qf', 'help', 'markdown']

let g:lens#disabled_filetypes = ['coc-explorer']

let g:extradite_showhash = 1
let g:extradite_diff_split = 'belowright vertical split'

let g:FerretExecutable          = 'rg,ag'
let g:FerretExecutableArguments = {
            \   'ag': '-i --vimgrep --hidden',
            \   'rg': '--vimgrep --no-heading --hidden'
            \ }

let g:highlightedyank_highlight_duration = 300

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_skiplist = [
            \ '*\\AppData\\Local\\Temp\\*',
            \ '*\\nvim\\runtime\\doc\\*',
            \ ]

let g:startify_bookmarks = [ {'i': '~/.config/nvim/init.vim'}, {'p': '~/.config/nvim/plugins.vim'}, ]
let g:startify_change_to_vcs_root  = 1
let g:startify_change_to_dir       = 1
let g:startify_fortune_use_unicode = 0
let g:startify_enable_unsafe       = 1
let g:floaterm_winblend            = 40
let g:floaterm_position            = 'center'

let g:webdevicons_enable                 = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_enable_startify        = 1
let g:coc_snippet_next                   = '<tab>'
let g:capture_open_command = ''
let g:capture_override_buffer = 'newbufwin'

let $VISUAL = 'nvr --remote-wait'
let $PATH   = $PATH . ':' . $HOME . '/go/bin'

let g:nefertiti_base_brightness_level = 14
let g:sierra_Sunset = 1
let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 1

let g:markdown_fenced_languages = [
            \ 'vim',
            \ 'help'
            \]

" plugin keymaps

map *  <Plug>(asterisk-z*)
map g* <Plug>(asterisk-gz*)
map #  <Plug>(asterisk-z#)
map g# <Plug>(asterisk-gz#)

inoremap <silent> <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-g>U<LT>Right>')<CR>
inoremap <silent> <Tab> <C-r>=<SID>my_itab_function()<CR>
inoremap <silent> <CR> <C-r>=<SID>my_icr_function()<CR>

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
nmap <silent> dn <Plug>(coc-diagnostic-next)
nmap <silent> dp <Plug>(coc-diagnostic-prev)
nmap s <Plug>(operator-replace)
nnoremap <silent> tt  :<C-u>FloatermToggle<CR>

nnoremap <Up>    :<C-u>Git push
nnoremap <Down>  :<C-u>Git pull
nnoremap <Right> :<C-u>Git commit -am ''<Left>
nnoremap <silent> <Left>  :<C-u>CocCommand explorer<CR>
nmap     <silent> <Leader>         <Plug>(asterisk-z*)
nnoremap <silent> <Leader>e        :<C-u>CocCommand explorer<CR>
nmap     <silent> <Leader>rf       <Plug>(coc-references)
nmap     <silent> <Leader>rn       <Plug>(coc-rename)
nmap              <Leader>a        <Plug>(FerretAck)
nnoremap <silent> <Leader>s        :<C-u>Startify<CR>
nmap     <silent> <Leader>df       <Plug>(coc-definition)
nnoremap <silent> <Leader>f        :<C-u>CocList files<CR>
nnoremap <silent> <Leader>g        :<C-u>CocList grep<CR>
nnoremap <silent> <Leader>h        :<C-u>call CocAction('doHover')<CR>
nmap              <Leader>l        <Plug>(FerretLack)
nnoremap <silent> <Leader>b        :<C-u>CocList buffers<CR>
nnoremap <silent> <Leader>m        :<C-u>CocList mru<CR>
nnoremap <silent> <Leader><Leader> :<C-u>CocList<CR>

xmap v                  <Plug>(expand_region_expand)
xmap <C-v>              <Plug>(expand_region_shrink)
xmap <silent> <Leader>f <Plug>(coc-format-selected)
xmap <CR>               <Plug>(LiveEasyAlign)

if g:tab_gui
    nnoremap <C-t> :<C-u>tabnext<CR>
    nnoremap <S-t> :<C-u>tabprevous<CR>
else
    nnoremap <C-t> :<C-u>bn<CR>
    nnoremap <S-t> :<C-u>bp<CR>
endif

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
command! PackUpdate :call minpac#update()
command! PackClean :call minpac#clean()
command! PackStatus :call minpac#status()

" functions

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ."  ". entry_path'
endfunction

function! LightlineReadonly()
    return &readonly ? "\ue0a2" : ''
endfunction

function! LightlineRepository()
    if !exists("b:git_dir")
        return ''
    endif
    return "\uf401 " . fnamemodify(b:git_dir, ":h:t")
endfunction

function! LightlineRepoStatus()
    return exists("b:git_dir") && exists('g:coc_git_status') ? g:coc_git_status : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . '  ' . &filetype : 'no ft') : WebDevIconsGetFileTypeSymbol()
endfunction

function! LightlineChanges()
    return exists('b:coc_git_status') && b:coc_git_status != '' ? "\uf440 " . substitute(substitute(substitute(b:coc_git_status, "+", "\uf457 ", ""), "-", "\uf458 ", ""), '\~', "\uf459 ", "") : ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . '  ' . &fileformat) : WebDevIconsGetFileFormatSymbol()
endfunction

function! LightlineWInfo()
    return winwidth(0) > 70 ? "\ufab1" . winnr() . ' ' . "\uf4a5 " . bufnr('%') : ''
endfunction

function! s:my_lexima_setup()
    call lexima#add_rule({'at': '\%#)', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
    call lexima#add_rule({'at': '\%#}', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
    call lexima#add_rule({'at': '\%#"', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
    call lexima#add_rule({'at': '\%#''', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
endfunction

function! s:my_icr_function()
    return pumvisible() ?
                \ coc#expandable() ?
                \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand', ''] )\<CR>" :
                \  "\<C-y>" :
                \ lexima#expand('<CR>', 'i')
endfunction

function! s:my_itab_function()
    return pumvisible() ?
                \ "\<C-n>" :
                \ coc#jumpable() ?
                \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-jump', ''] )\<CR>" :
                \ lexima#insmode#leave(1, '<Tab>')
endfunction

function! s:my_diffenter_function()
    DisableWhitespace
endfunction

function! s:my_diffexit_function()
    EnableWhitespace
    diffoff
endfunction

autocmd MyAutoCmd ColorScheme * :highlight Comment gui=none
autocmd MyAutoCmd ColorScheme * :highlight! link NonText vimade_0
autocmd MyAutoCmd ColorScheme * :highlight! link SpecialKey vimade_0
autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_icr_function()<CR>
autocmd MyAutoCmd VimEnter * call <SID>my_lexima_setup()
autocmd MyAutoCmd BufEnter * :Sleuth
autocmd MyAutoCmd InsertLeave * silent! pclose!
autocmd MyAutoCmd OptionSet diff if &diff | call <SID>my_diffenter_function() | endif
autocmd MyAutoCmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | call <SID>my_diffexit_function() | endif

if !g:completion_gui
    autocmd MyAutoCmd BufWritePre *.go :CocCommand editor.action.organizeImport
endif
