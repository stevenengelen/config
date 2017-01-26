" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allows us to paste stuff from outside vim in vim
set clipboard=unnamed

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


set number

"word wrap at the end of a line
set wrap
"set wm=1

"Remap window moving
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" decide where the new window will come
set splitbelow
set splitright

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif
" python related settings
au BufNewFile,BufRead *.py
    \ set shiftwidth=4 			" >> << indents 4 columns
    \ set tabstop=4				" hard tab is 4 columns
    \ set expandtab				" convert tabs to spaces
    \ set softtabstop=4           " and insert/delete 4 spaces when hitting a TAB/BACKSPACE
    \ set shiftround              " round indent to multiple of 'shiftwidth'
    \ set foldmethod=indent       " enable folding
    \ set foldlevel=99
    \ nnorempa <space> za         " enable folding with the spacebar
" enable pathogen
execute pathogen#infect()
