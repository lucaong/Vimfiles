" Pathogen (bundles)
call pathogen#infect()
call pathogen#helptags()

" Syntax
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Various sensible defaults
set backspace=indent,eol,start
set complete-=i
set showmatch
set autoindent
set smarttab
set ttimeoutlen=50
set incsearch hlsearch
set smartcase
set laststatus=2
set ruler
set showcmd
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set autoread
set autowrite
set fileformats=unix
set wildmode=list:full
nnoremap Y y$
set textwidth=80

" Theme
set background=dark
if !has("gui_running")
   let g:gruvbox_italic=0
endif
colorscheme gruvbox
set guifont="Monaco for Powerline 14"
set number

" Clipboard
set clipboard=unnamed

" Tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Backup and swap files
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp
set nobackup
set noswapfile
set nowritebackup

" History and autocomplete
set history=1000
set wildmenu
set wildmode=list:longest
set completeopt+=menu,menuone,noinsert
set shortmess+=c

" Shell
set shell=/bin/zsh

" Moving around
nnoremap j gj
nnoremap k gk
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

" Moving between splits
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

" Moving between tabs
nmap tl gt
nmap th gT

" Get rid of annoying register rewriting when pasting on visually selected
" text.
"
" Note: magic
function! RestoreRegister()
  let @" = s:restore_reg
  let @* = s:restore_reg_star
  let @+ = s:restore_reg_plus
  return ''
endfunction
function! s:Repl()
  let s:restore_reg      = @"
  let s:restore_reg_star = @*
  let s:restore_reg_plus = @+
  return "p@=RestoreRegister()\<cr>"
endfunction
xnoremap <silent> <expr> p <SID>Repl()

" Splitjoin
" map s to <Nop> (as I don't use it, and it would interfere here)
nmap s <Nop>
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
let g:splitjoin_normalize_whitespace = 1
let g:splitjoin_align = 1
nmap sk :SplitjoinJoin<cr>
nmap sj :SplitjoinSplit<cr>

" NERDTree
nmap gn :NERDTreeToggle<cr>
nmap fn :NERDTreeFind<cr>

" Ack (Andrew's fork)
let g:ack_default_options = ' -H --nocolor --nogroup --column --ignore-dir="node_modules" --ignore-dir="log" --ignore-dir="coverage"'

" Remap esc
inoremap kj <Esc>

" Airline
set encoding=utf-8
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

nnoremap _e :split $MYVIMRC<cr>
nnoremap vv _vg_

" toggle folding
nnoremap <space> za

" Vim Switch
nnoremap <tab> :Switch<cr>
let g:todo_switch_definition =
      \ {
      \    '- \[ \]\(.*\)$': '- [x]\1',
      \    '- \[x\]\(.*\)$': '- [ ]\1',
      \ }

" Projectionist globals
let g:projectionist_heuristics = {
      \ "shard.yml|shards.yml": {
      \   "src/*.cr": {"alternate": "spec/{}_spec.cr"},
      \   "spec/*_spec.cr": {"type": "spec", "alternate": "src/{}.cr"},
      \ }}

" vim-test
let test#strategy = "dispatch"

" Clojure (vim-fireplace)
nmap gd <Plug>FireplaceK

" Copy current file's name
nnoremap gy :call <SID>YankFilename(1)<cr>
nnoremap gY :call <SID>YankFilename(0)<cr>
function! s:YankFilename(relative)
  let @@ = expand('%:p')

  if a:relative " then relativize it
    let @@ = fnamemodify(@@, ':~:.')
  endif

  let @* = @@
  let @+ = @@

  echo 'Yanked "'.@@.'" to clipboard'
endfunction

" SameLevel
" Jump to same indentation level
function! SameLevel()
  let level = indent(".")
  let indent_based = ["coffee", "haml", "python"]

  " If end of file
  if search('^\s\{1,'.level.'}\S', 'W') <= 0
    execute "normal! Go\<Esc>o"

  " If non indent-based
  elseif index( indent_based, &filetype ) < 0
    execute "normal! o\<Esc>o"

  " If indent-based
  else
    execute "normal! O\<Esc>"
    " Clean line in case of comments
    if col(".") > 1
      execute "normal! v0d"
    endif
    execute "normal! O"
  endif

  execute "normal! a" . repeat( ' ', level + 1 )
  startinsert
endfunction

nnoremap sl :call SameLevel()<cr>
nnoremap cl :execute ':set cc='.(indent(".") + 1)<cr>

" Rspec command to run rspec with vim Dispatch
function! Rspec(line)
  if a:line
    execute "Dispatch bundle exec rspec " . @% . ":" . a:line
  else
    execute "Dispatch bundle exec rspec " . @%
  endif
endfunction
command -count=0 Rspec execute Rspec(<count>)
command RspecAll Dispatch bundle exec rspec

" Mucomplete
let g:mucomplete#enable_auto_at_startup = 1
set completeopt-=preview

" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'jsx': ['standard'], 'javascript': ['standard'], 'elixir': ['elixir-ls']}
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_fixers = {'jsx': ['standard'], 'javascript': ['standard'], 'elixir': ['mix_format']}
let g:ale_elixir_elixir_ls_release = '/Users/luca/.vim/bundle/elixir-ls/release'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Exotic extensions
autocmd BufNewFile,BufRead *.prawn set syntax=ruby

" Tsuquyomi (for TypeScript)
set ballooneval
autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
autocmd FileType typescript.tsx setlocal balloonexpr=tsuquyomi#balloonexpr()
autocmd FileType typescript nmap <buffer> T : <C-u>echo tsuquyomi#hint()<CR>
autocmd FileType typescript.tsx nmap <buffer> T : <C-u>echo tsuquyomi#hint()<CR>

" Vim Move
let g:move_key_modifier = 'C'

" Vim JavaScript
let g:javascript_plugin_jsdoc = 1

" Language Server Support
" Setup requires:
"   - async.vim to normalize async API of Vim 8 and nvim
"   - asyncomplete.vim
"   - asyncomplete-lsp.vim
"
" See: https://medium.com/@vanuan/vim-for-typescript-and-react-in-2020-9724b9139be2
" TypeScript Language Server
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'TypeScript support using typescript-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
    \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
    \ })
else
  echohl ErrorMsg
  echom 'Sorry, `typescript-language-server` is not installed. See :h vim-lsp-typescript for more details on setup.'
  echohl NONE
endif

" Ruby Language Server (solargraph)
if executable('solargraph')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'Ruby support using Solargraph',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Gemfile'))},
    \ 'whitelist': ['ruby'],
    \ })
else
  echohl ErrorMsg
  echom 'Sorry, `solargraph` is not installed. See :h vim-lsp-typescript for more details on setup.'
  echohl NONE
endif
