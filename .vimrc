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

" Theme
set background=dark
colorscheme BusyBee_TS
set guifont="Monaco for Powerline 14"
set number

" Tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Backup and swap files
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

" History and autocomplete
set history=1000
set wildmenu
set wildmode=list:longest

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
let g:ackprg = 'ack -H --nocolor --nogroup --column --ignore-dir="node_modules" --ignore-dir="log"'

" Remap esc
inoremap kj <Esc>

" Powerline
set encoding=utf-8
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

nnoremap _e :split $MYVIMRC<cr>
nnoremap vv _vg_

" toggle folding
nnoremap <space> za

" Clipboard
set clipboard=unnamed

nnoremap <tab> :Switch<cr>

let g:todo_switch_definition =
      \ {
      \    '- \[ \]\(.*\)$': '- [x]\1', 
      \    '- \[x\]\(.*\)$': '- [ ]\1', 
      \ }

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
