-- plugin install
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt


cmd[[packadd packer.nvim]]

require'packer'.startup(function()

    -- editor display
    use'lukas-reineke/indent-blankline.nvim'
    use'ryanoasis/vim-devicons'
    use'lilydjwg/colorizer'
    use'tweekmonster/startuptime.vim'
    use'mhinz/vim-startify'
    use'itchyny/lightline.vim'
    use'mengelbrecht/lightline-bufferline'
    use'ntpeters/vim-better-whitespace'
    use'rickhowe/diffchar.vim'
    use'romainl/vim-qf'
    use'TaDaa/vimade'
    use'andymass/vim-matchup'
    use'camspiers/animate.vim'
    use'camspiers/lens.vim'
    use'itchyny/vim-cursorword'
    use'nvim-treesitter/nvim-treesitter'

    -- text/input manipulation
    use'cohama/lexima.vim'
    use'godlygeek/tabular'
    use'machakann/vim-highlightedyank'
    use'rhysd/accelerated-jk'
    use'tpope/vim-surround'
    use'tpope/vim-commentary'
    use'tpope/vim-sleuth'
    use'kana/vim-textobj-user'
    use'kana/vim-textobj-line'
    use'kana/vim-smartword'
    use'kana/vim-niceblock'
    use'haya14busa/vim-asterisk'
    use'terryma/vim-expand-region'
    use{'wincent/ferret', opt = true, cmd = {'<Plug>(FerretAck)'}}
    use'kana/vim-operator-user'
    use'kana/vim-operator-replace'
    use{'tyru/capture.vim', opt = true, cmd = {'Capture'}}
    use'junegunn/vim-easy-align'

    -- file/directory
    use'januswel/fencja.vim'
    use'voldikss/vim-floaterm'

    -- git
    use'tpope/vim-fugitive'
    use'int3/vim-extradite'

    -- language support
    use'mechatroner/rainbow_csv'
    use'tpope/vim-dadbod'
    use'editorconfig/editorconfig-vim'
    use'honza/vim-snippets'
    use'pechorin/any-jump.vim'

    -- colorscheme
    use{'jeetsukumaran/vim-nefertiti', opt = true}
    use{'Nequo/vim-allomancer', opt = true}
    use{'ajmwagar/vim-deus', opt = true}
    use{'sainnhe/edge', opt = true}
    use{'tyrannicaltoucan/vim-quantum', opt = true}
    use'tyrannicaltoucan/vim-deep-space'
    use{'knt419/lightline-colorscheme-themecolor', opt = true}
end)

-- lsp/completion

-- plugin variables

--require'nvim-treesitter.configs'.setup {
--    highlight = {
--        enable = true
--        }
--    }
--require'nvim-treesitter.configs'.setup {
--  matchup = {
--    enable = true
--  }
--}

-- tabline
--if !g:tab_gui
--    set showtabline=2
--endif

-- statusline
--if g:statusline_gui
--    set laststatus=0
--endif

-- cmdline
--if g:cmdline_gui
--    set cmdheight=1
--endif

--[[
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
            \   'left': [['winfo', 'buffers'] ],
            \   'right': [['repostatus','repository'] ]
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
            ]]
-- plugin keymaps

cmd[[map *  <Plug>(asterisk-z*)]]
cmd[[map g* <Plug>(asterisk-gz*)]]
cmd[[map #  <Plug>(asterisk-z#)]]
cmd[[map g# <Plug>(asterisk-gz#)]]

cmd[[inoremap <silent> <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-g>U<LT>Right>')<CR>]]
--cmd[[inoremap <silent> <Tab> <C-r>=<SID>my_itab_function()<CR>]]
--cmd[[inoremap <silent> <CR> <C-r>=<SID>my_icr_function()<CR>]]

cmd[[nmap j <Plug>(accelerated_jk_gj)]]
cmd[[nmap k <Plug>(accelerated_jk_gk)]]
cmd[[nmap w <Plug>(smartword-w)]]
cmd[[nmap b <Plug>(smartword-b)]]
cmd[[nmap e <Plug>(smartword-e)]]
cmd[[nmap ge <Plug>(smartword-ge)]]
cmd[[nmap <silent> dn <Plug>(coc-diagnostic-next)]]
cmd[[nmap <silent> dp <Plug>(coc-diagnostic-prev)]]
cmd[[nmap s <Plug>(operator-replace)]]
cmd[[nnoremap <silent> tt  :<C-u>FloatermToggle<CR>]]

cmd[[nnoremap <Up>    :<C-u>Git push]]
cmd[[nnoremap <Down>  :<C-u>Git pull]]
cmd[[nnoremap <Right> :<C-u>Git commit -am ''<Left>]]
cmd[[nnoremap <silent> <Left>  :<C-u>CocCommand explorer<CR>]]
cmd[[nmap     <silent> <Leader>         <Plug>(asterisk-z*)]]
cmd[[nnoremap <silent> <Leader>e        :<C-u>CocCommand explorer<CR>]]
cmd[[nmap     <silent> <Leader>rf       <Plug>(coc-references)]]
cmd[[nmap     <silent> <Leader>rn       <Plug>(coc-rename)]]
cmd[[nmap              <Leader>a        <Plug>(FerretAck)]]
cmd[[nnoremap <silent> <Leader>s        :<C-u>Startify<CR>]]
cmd[[nmap     <silent> <Leader>df       <Plug>(coc-definition)]]
cmd[[nnoremap <silent> <Leader>f        :<C-u>CocList files<CR>]]
cmd[[nnoremap <silent> <Leader>g        :<C-u>CocList grep<CR>]]
cmd[[nnoremap <silent> <Leader>h        :<C-u>call CocAction('doHover')<CR>]]
cmd[[nmap              <Leader>l        <Plug>(FerretLack)]]
cmd[[nnoremap <silent> <Leader>b        :<C-u>CocList buffers<CR>]]
cmd[[nnoremap <silent> <Leader>m        :<C-u>CocList mru<CR>]]
cmd[[nnoremap <silent> <Leader><Leader> :<C-u>CocList<CR>]]

cmd[[xmap v                  <Plug>(expand_region_expand)]]
cmd[[xmap <C-v>              <Plug>(expand_region_shrink)]]
cmd[[xmap <silent> <Leader>f <Plug>(coc-format-selected)]]
cmd[[xmap <CR>               <Plug>(LiveEasyAlign)]]

--if g:tab_gui
--    nnoremap <C-t> :<C-u>tabnext<CR>
--    nnoremap <S-t> :<C-u>tabprevous<CR>
--else
--    nnoremap <C-t> :<C-u>bn<CR>
--    nnoremap <S-t> :<C-u>bp<CR>
--endif

-- Use `:Format` for format current buffer
--command! -nargs=0 Format :call CocAction('format'
--command! PackUpdate :call minpac#update()
--command! PackClean :call minpac#clean()
--command! PackStatus :call minpac#status()

-- functions

--[[
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ."  ". entry_path'
end

function! LightlineReadonly()
    return &readonly ? "\ue0a2" : ''
end

function! LightlineRepository()
    if !exists("b:git_dir")
        return ''
    endif
    return "\uf401 " . fnamemodify(b:git_dir, ":h:t")
end

function! LightlineRepoStatus()
    return exists("b:git_dir") && exists('g:coc_git_status') ? g:coc_git_status : ''
end

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
                \ lexima#expand('<CR>', 'i'
endfunction

function! s:my_itab_function()
    return pumvisible() ?
                \ "\<C-n>" :
                \ coc#jumpable() ?
                \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-jump', ''] )\<CR>" :
                \ lexima#insmode#leave(1, '<Tab>'
endfunction

function! s:my_diffenter_function()
    DisableWhitespace
endfunction

function! s:my_diffexit_function()
    EnableWhitespace
    diffoff
endfunction
]]
--cmd[[autocmd MyAutoCmd ColorScheme * :highlight Comment gui=none]]
--cmd[[autocmd MyAutoCmd ColorScheme * :highlight! link NonText vimade_0]]
--cmd[[autocmd MyAutoCmd ColorScheme * :highlight! link SpecialKey vimade_0]]
--cmd[[autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_icr_function()<CR>]]
--cmd[[autocmd MyAutoCmd VimEnter * call <SID>my_lexima_setup()]]
--cmd[[autocmd MyAutoCmd BufEnter * :Sleuth]]
cmd[[autocmd MyAutoCmd InsertLeave * silent! pclose!]]
--cmd[[autocmd MyAutoCmd OptionSet diff if &diff | call <SID>my_diffenter_function() | endif]]
--cmd[[autocmd MyAutoCmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | call <SID>my_diffexit_function() | endif]]

--if !g:completion_gui
--    autocmd MyAutoCmd BufWritePre *.go :CocCommand editor.action.organizeImport
--endif
