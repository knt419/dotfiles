" gui elements
let g:tab_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gnvim')
let g:statusline_gui = exists('g:gui_oni') || exists('g:veonim')
let g:completion_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gnvim')
let g:cmdline_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gonvim_running') || exists('g:gnvim')


" plugin install
call plugpac#begin()

Pack 'k-takata/minpac', {'type': 'opt', 'branch': 'devel'}

" editor display
Pack 'Yggdroot/indentLine'
Pack 'ryanoasis/vim-devicons'
Pack 'lilydjwg/colorizer', {'type': 'lazy'}
Pack 'mhinz/vim-startify'
Pack 'itchyny/lightline.vim'
Pack 'mengelbrecht/lightline-bufferline'
Pack 'ntpeters/vim-better-whitespace', {'type': 'lazy'}
Pack 'rickhowe/diffchar.vim', {'type': 'lazy'}
Pack 'romainl/vim-qf', {'type': 'lazy'}
Pack 'TaDaa/vimade', {'type': 'lazy'}
Pack 'andymass/vim-matchup', {'type': 'lazy'}
Pack 'camspiers/animate.vim'
Pack 'camspiers/lens.vim'
Pack 'itchyny/vim-cursorword'

" text/input manipulation
Pack 'cohama/lexima.vim', {'type': 'lazy'}
Pack 'junegunn/vim-easy-align', {'type': 'opt', 'on': '<Plug>(LiveEasyAlign)'}
Pack 'godlygeek/tabular', {'type': 'lazy'}
Pack 'machakann/vim-highlightedyank', {'type': 'lazy'}
Pack 'rhysd/accelerated-jk'
Pack 'tpope/vim-surround', {'type': 'lazy'}
Pack 'tpope/vim-commentary', {'type': 'lazy'}
Pack 'tpope/vim-sleuth', {'type': 'lazy'}
Pack 'kana/vim-textobj-user', {'type': 'lazy'}
Pack 'kana/vim-textobj-line', {'type': 'lazy'}
Pack 'kana/vim-smartword', {'type': 'lazy'}
Pack 'kana/vim-niceblock', {'type': 'lazy'}
Pack 'haya14busa/vim-asterisk', {'type': 'lazy'}
Pack 'terryma/vim-expand-region', {'type': 'lazy'}
Pack 'wincent/ferret', {'type': 'lazy'}
Pack 'kana/vim-operator-user', {'type': 'lazy'}
Pack 'kana/vim-operator-replace', {'type': 'lazy'}
Pack 'tyru/capture.vim', {'type': 'lazy'}

" file/directory
Pack 'januswel/fencja.vim', {'type': 'lazy'}
Pack 'voldikss/vim-floaterm', {'type': 'lazy'}

" git
Pack 'tpope/vim-fugitive', {'type': 'lazy'}
Pack 'int3/vim-extradite', {'type': 'lazy'}

" language support
Pack 'sheerun/vim-polyglot'
Pack 'mechatroner/rainbow_csv', {'for': 'csv'}
Pack 'tpope/vim-dadbod', {'type': 'lazy'}
Pack 'editorconfig/editorconfig-vim', {'type': 'lazy'}
Pack 'honza/vim-snippets', {'type': 'lazy'}

" colorscheme
Pack 'jeetsukumaran/vim-nefertiti', {'type': 'opt'}
Pack 'Nequo/vim-allomancer', {'type': 'opt'}
Pack 'ajmwagar/vim-deus', {'type': 'opt'}
Pack 'sainnhe/edge', {'type': 'opt'}
Pack 'tyrannicaltoucan/vim-quantum', {'type': 'opt'}
Pack 'tyrannicaltoucan/vim-deep-space'
Pack 'knt419/lightline-colorscheme-themecolor', {'type': 'opt'}

" lsp/completion
if !g:completion_gui
    Pack 'neoclide/coc.nvim', {'do': {-> system('yarn install --frozen-lockfile')}}
    set completeopt=noinsert,menuone,noselect,preview
    set shortmess+=c
    Pack 'neoclide/coc-git',  {'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'neoclide/coc-json',  {'for': 'json', 'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'neoclide/coc-yaml',  {'for': 'yaml', 'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'neoclide/coc-lists', {'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'neoclide/coc-snippets', {'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'neoclide/coc-java', {'for': 'java', 'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'neoclide/coc-prettier', {'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'josa42/coc-go', {'for': 'go', 'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'iamcco/coc-vimlsp', {'do': {-> system('yarn install --frozen-lockfile')}}
    Pack 'weirongxu/coc-explorer', {'do': {-> system('yarn install --frozen-lockfile')}}
endif

" gonvim
if exists('g:gonvim_running')
    Pack 'akiyosi/gonvim-fuzzy'
    Pack 'equalsraf/neovim-gui-shim'
endif

Pack 'glacambre/firenvim', {'type': 'opt'}

call plugpac#end()

" plugin variables

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
            \   'percentage': '%3p%%',
            \ },
            \ 'component_function': {
            \    'readonly'   : 'LightlineReadonly',
            \    'repository': 'LightlineRepository',
            \    'repostatus': 'LightlineRepoStatus',
            \    'filetype'   : 'LightlineFiletype',
            \    'fileformat': 'LightlineFileformat',
            \    'changes'    : 'LightlineChanges',
            \    'cocstatus'  : 'coc#status',
            \    'winfo'      : 'LightlineWinfo'
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

let g:startify_skiplist = [
            \ '*\\AppData\\Local\\Temp\\*',
            \ '*\\nvim\\runtime\\doc\\*',
            \ ]

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

nnoremap <Up>    :<C-u>Gpush
nnoremap <Down>  :<C-u>Gpull
nnoremap <Right> :<C-u>Gcommit -am ''<Left>
nnoremap <silent> <Left>  :<C-u>CocCommand explorer<CR>

nnoremap <silent> <Leader>e        :<C-u>CocCommand explorer<CR>
nmap     <silent> <Leader>rf       <Plug>(coc-references)
nmap     <silent> <Leader>rn       <Plug>(coc-rename)
nmap     <Leader>a        <Plug>(FerretAck)
nnoremap <silent> <Leader>s        :<C-u>Startify<CR>
nmap     <silent> <Leader>df       <Plug>(coc-definition)
nnoremap <silent> <Leader>f        :<C-u>CocList files<CR>
nnoremap <silent> <Leader>g        :<C-u>CocList grep<CR>
nnoremap <silent> <Leader>h        :<C-u>call CocAction('doHover')<CR>
nmap     <silent> <Leader>j        <Plug>(AerojumpBolt)
nmap     <Leader>l        <Plug>(FerretLack)
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


if exists('g:veonim')
    " extensions for web dev
    let g:vscode_extensions = [
                \'vscode.typescript-language-features',
                \'vscode.json-language-features',
                \'vscode.css-language-features',
                \]

    " workspace functions
    nnoremap <silent> <Leader>f :Veonim files<CR>
    nnoremap <silent> <Leader>e :Veonim explorer<CR>
    nnoremap <silent> <Leader>b :Veonim buffers<CR>

    " searching text
    nnoremap <silent> <Leader>gw :Veonim grep-word<CR>
    vnoremap <silent> <Leader>gw :Veonim grep-selection<CR>
    nnoremap <silent> <Leader>ga :Veonim grep<CR>
    nnoremap <silent> <Leader>gf :Veonim grep-resume<CR>
    nnoremap <silent> <Leader>gb :Veonim buffer-search<CR>

    " color picker
    nnoremap <silent> sc :Veonim pick-color<CR>

    " language server functions
    nnoremap <silent> sr :Veonim rename<CR>
    nnoremap <silent> sd :Veonim definition<CR>
    nnoremap <silent> st :Veonim type-definition<CR>
    nnoremap <silent> si :Veonim implementation<CR>
    nnoremap <silent> sf :Veonim references<CR>
    nnoremap <silent> sh :Veonim hover<CR>
    nnoremap <silent> sl :Veonim symbols<CR>
    nnoremap <silent> so :Veonim workspace-symbols<CR>

endif

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

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

function! LightlineWinfo()
    return "\ufab1" . winnr() . ' ' . "\uf4a5 " . bufnr('%')
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
    :DisableWhitespace
endfunction

function! s:my_diffexit_function()
    :EnableWhitespace
    diffoff
endfunction

function! s:my_cwordinfo_function()
    let s:cursor_word = expand('<cword>')
    if len(s:cursor_word) < 3
        return
    endif
    let s:save_pos = getpos(".") |
    redir => s:wordcount
    silent execute ':%s/' . s:cursor_word . '//gn'
    redir END
    call setpos('.', s:save_pos)
    echo 'word on cursor : "' . s:cursor_word . '" : ' . substitute(s:wordcount, '\n', '', '')
endfunction

autocmd MyAutoCmd ColorScheme * :highlight Comment gui=none
autocmd MyAutoCmd ColorScheme * :highlight! link NonText vimade_0
autocmd MyAutoCmd ColorScheme * :highlight! link SpecialKey vimade_0
autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_icr_function()<CR>
autocmd MyAutoCmd InsertLeave * silent! pclose!
autocmd MyAutoCmd OptionSet diff if &diff | call <SID>my_diffenter_function() | endif
autocmd MyAutoCmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | call <SID>my_diffexit_function() | endif
if !g:completion_gui
    autocmd MyAutoCmd CursorHold * call <SID>my_cwordinfo_function()
    autocmd MyAutoCmd BufWritePre *.go :CocCommand editor.action.organizeImport
endif
