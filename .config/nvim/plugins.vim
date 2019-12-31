" gui elements
let g:tab_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gnvim') || exists('g:gonvim_running')
let g:statusline_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gonvim_running')
let g:completion_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gnvim')
let g:cmdline_gui = exists('g:gui_oni') || exists('g:veonim') || exists('g:gonvim_running') || exists('g:gnvim')


" plugin install
call plug#begin(g:plug_repo_dir)

" editor display
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'itchyny/vim-parenmatch'
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rickhowe/diffchar.vim'
Plug 'romainl/vim-qf'
Plug 'TaDaa/vimade'
Plug 'Shougo/echodoc.vim'

" text/input manipulation
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'machakann/vim-highlightedyank'
Plug 'rhysd/accelerated-jk'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-smartword', { 'on': '<Plug>(smartword-' }
Plug 'kana/vim-smartchr'
Plug 'kana/vim-niceblock'
Plug 'haya14busa/vim-asterisk', { 'on': '<Plug>(asterisk-' }
Plug 'terryma/vim-expand-region'
Plug 'wincent/ferret'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins'}

" file/directory
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'sh8/defx-icons'
Plug 'januswel/fencja.vim'
Plug 'voldikss/vim-floaterm'

" git
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'

" language support
Plug 'sheerun/vim-polyglot'
Plug 'mechatroner/rainbow_csv', { 'for': 'csv' }
Plug 'tpope/vim-dadbod'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'

" colorscheme
Plug 'jeetsukumaran/vim-nefertiti'
Plug 'Nequo/vim-allomancer'
Plug 'ajmwagar/vim-deus'
Plug 'sainnhe/edge'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'knt419/lightline-colorscheme-themecolor'

" lsp/completion
if !g:completion_gui
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    set completeopt=noinsert,menuone,noselect,preview
    set shortmess+=c
endif

" gonvim
if exists('g:gonvim_running')
    Plug 'akiyosi/gonvim-fuzzy'
    Plug 'equalsraf/neovim-gui-shim'
endif

Plug 'glacambre/firenvim'

call plug#end()

" plugin variables

"tabline
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
            \      ['mode', 'paste', 'cocstatus'],
            \    ],
            \    'right': [
            \      ['readonly', 'changes', 'filetype', 'fileformat', 'fileencoding', 'lineinfo', 'percentage'],
            \    ]
            \ },
            \ 'tabline': {
            \   'left': [['buffers']],
            \   'right': [['repostatus','repository']]
            \ },
            \ 'component': {
            \   'lineinfo': "\ue0a1".'%3l:%3v',
            \   'percentage': '%3p%%',
            \ },
            \ 'component_function': {
            \    'readonly'   : 'LightlineReadonly',
            \    'repository' : 'LightlineRepository',
            \    'repostatus' : 'LightlineRepoStatus',
            \    'filetype'   : 'LightlineFiletype',
            \    'fileformat' : 'LightlineFileformat',
            \    'changes'    : 'LightlineChanges',
            \    'cocstatus'  : 'coc#status'
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers',
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel',
            \ },
            \ 'mode_map': {
            \   'n' : "\ufc44",
            \   'i' : "\uf040",
            \   'R' : "\uf954",
            \   'v' : "\uf988",
            \   'V' : "\uf988".'LINE',
            \   "\<C-v>": "\uf988".'BLOCK',
            \   'c' : "\ufcb5",
            \   's' : "\uf044",
            \   'S' : "\uf044 ".'LINE',
            \   "\<C-s>": "\uf044 ".'BLOCK',
            \   't': "\uf68c",
            \ },
            \ 'enable': {
            \   'statusline': !g:statusline_gui,
            \   'tabline': !g:tab_gui
            \ },
            \ 'separator': {
            \   'left': "\ue0b8",
            \   'right': "\ue0ba"
            \ },
            \ 'subseparator': {
            \   'left': "│",
            \   'right': "│"
            \ },
            \ 'tabline_separator': {
            \   'left': "\ue0bc",
            \   'right': "\ue0be"
            \ },
            \ 'tabline_subseparator': {
            \   'left': "│",
            \   'right': "│"
            \ },
            \ }

            " \   'right': "│"
if winwidth(0) < 100
    let g:lightline#bufferline#filename_modifier = ':t'
endif

if has('win32') || has('win64')
    let g:FerretNvim                = 0
    let g:FerretJob                 = 0
endif

let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1

" let g:indentLine_setColors      = 0
let g:indentLine_bufTypeExclude = ['help', 'terminal']
let g:indentLine_fileTypeExclude = ['startify']
let g:lexima_ctrlh_as_backspace = 1


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
let g:defx_icons_enable_syntax_highlight = 0
let g:defx_icons_column_length           = 2
let g:coc_snippet_next                   = '<tab>'

let $VISUAL = 'nvr --remote-wait'
let $PATH   = $PATH . ':' . $HOME . '/go/bin'

let g:nefertiti_base_brightness_level = 14
let g:sierra_Sunset = 1
let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 1

let g:coc_global_extensions = ['coc-json',
            \ 'coc-git', 'coc-yaml', 'coc-prettier', 'coc-vimlsp',
            \ 'coc-lists', 'coc-go', 'coc-snippets', 'coc-highlight']

let g:echodoc#enable_at_startup = 1
let g:echodoc#type              = 'floating'
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
vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
nmap <silent> <S-n> <Plug>(coc-diagnostic-next)
nmap <silent> <S-p> <Plug>(coc-diagnostic-prev)
nmap s <Plug>(operator-replace)


nmap <silent> <Leader>a <Plug>(FerretAck)
nmap <silent> <Leader>l <Plug>(FerretLack)
nmap <silent> <Leader>rf <Plug>(coc-references)
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>df <Plug>(coc-definition)
nmap <silent> <Leader>j <Plug>(AerojumpBolt)
nnoremap <silent> <Leader>h :<C-u>call CocAction('doHover')<CR>
nnoremap <silent> <Leader>s :<C-u>Startify<CR>
nnoremap <silent> <Leader>e :<C-u>Defx<CR>
nnoremap <silent> <Leader>z :<C-u>Defx -resume<CR>
nnoremap <silent> <Leader>f :<C-u>CocList files<CR>
nnoremap <silent> <Leader>m :<C-u>CocList mru<CR>
nnoremap <silent> <Leader>b :<C-u>CocList buffers<CR>
nnoremap <silent> <Leader>g :<C-u>CocList grep<CR>
nnoremap <silent> <Leader><Leader> :<C-u>CocList<CR>
xmap <silent> <Leader>f  <Plug>(coc-format-selected)

nnoremap <silent> tt  :<C-u>FloatermToggle<CR>
inoremap <silent> tt  <Esc>:<C-u>FloatermToggle<CR>

vmap <CR> <Plug>(LiveEasyAlign)

if g:tab_gui
    nnoremap <C-t> :<C-u>tabnext<CR>
    nnoremap <S-t> :<C-u>tabprevous<CR>
else
    nnoremap <C-t> :<C-u>bn<CR>
    nnoremap <S-t> :<C-u>bp<CR>
endif

inoremap <expr> ;  smartchr#one_of(';', '"')
inoremap <expr> :  smartchr#one_of(':', '''')
inoremap <expr> -  smartchr#one_of('-', '=')
inoremap <expr> ,  smartchr#one_of(',', '(')
inoremap <expr> .  smartchr#one_of('.', ')')
inoremap <expr> @  smartchr#one_of('@', '''', '"')

if exists('g:veonim')
    " extensions for web dev
    let g:vscode_extensions = [
                \'vscode.typescript-language-features',
                \'vscode.json-language-features',
                \'vscode.css-language-features',
                \'vscode.markdown-language-features',
                \'vscode.html-language-features',
                \'rust-lang.rust',
                \'ms-python.python',
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
    return exists("b:git_dir") && exists('g:coc_git_status') ? substitute(g:coc_git_status, "\ue0a0", "\ue725", "g")  : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . '  ' . &filetype : 'no ft') : WebDevIconsGetFileTypeSymbol()
endfunction

function! LightlineChanges()
    return exists('b:coc_git_status') ? "\uf440" . b:coc_git_status : ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . '  ' . &fileformat) : WebDevIconsGetFileFormatSymbol()
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

if &runtimepath =~# 'defx.nvim'
    call defx#custom#option('_', {
                \ 'columns': 'mark:indent:icons:filename:type:size:time',
                \ 'listed': v:true,
                \ 'show_ignored_files': v:true,
                \ })
endif

function! s:my_defx_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')
    nnoremap <silent><buffer><expr> e defx#do_action('open')
    nnoremap <silent><buffer><expr> c defx#do_action('copy')
    nnoremap <silent><buffer><expr> m defx#do_action('move')
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> l defx#do_action('open')
    nnoremap <silent><buffer><expr> o defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> i defx#do_action('new_file')
    nnoremap <silent><buffer><expr> d defx#do_action('remove')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
endfunction

autocmd MyAutoCmd ColorScheme * :highlight Comment gui=none
autocmd MyAutoCmd ColorScheme * :highlight! link NonText vimade_0
autocmd MyAutoCmd ColorScheme * :highlight! link SpecialKey vimade_0
autocmd MyAutoCmd ColorScheme * :highlight! link CocHighlightText Search
autocmd MyAutoCmd BufWritePre *.go :CocCommand editor.action.organizeImport
autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_icr_function()<CR>
autocmd MyAutoCmd InsertLeave * silent! pclose!
autocmd MyAutoCmd FileType defx call s:my_defx_settings()
autocmd MyAutoCmd CursorHold * silent call CocActionAsync('highlight')
