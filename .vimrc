runtime! debian.vim
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off		" required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'				" syntax checking python
Plugin 'nvie/vim-flake8'					" PEP8 checking
Plugin 'jnurmine/Zenburn'					" color scheme for terminal
Plugin 'altercation/vim-colors-solarized'	" color scheme for GUI
Plugin 'kien/ctrlp.vim'						" super searching
Plugin 'tpope/vim-fugitive'					" git integration
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}	" powerline
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" allows us to paste stuff from outside vim in vim
set clipboard=unnamed

set encoding=utf-8

" set mapleader
let mapleader="\\"

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
	let python_highlight_all=1		
  	syntax on
  	set hlsearch
endif

if has("autocmd")
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
	set background=dark
	colorscheme solarized
else
    colorscheme zenburn
endif

call togglebg#map("<F5>") " toggles between light and dark theme

" Toggle NERDTree on/off, with NERDTree in each tab, not just the active tab
map <Leader>t <plug>NERDTreeTabsToggle<CR>

" python related settings
autocmd FileType python 
  \ set tabstop=4               			  " hard tab is 4 columns
  \ set shiftwidth=4            			  " >> << indents 4 columns
  \ set expandtab					  " convert tabs to spaces
  \ set softtabstop=4	         			  " and insert/delete 4 spaces when hitting a TAB/BACKSPACE
  \ set shiftround   					  " round indent to multiple of 'shiftwidth'
autocmd BufReadPre *.py let g:SimpylFold_docstring_preview = 1	" preview docstrings
" Define the highlight group
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" autocomplete YouCompleteMe closes window after completion
let g:ycm_autoclose_preview_window_after_completion=1
" leader g opens GoTo dialog YouCompleteMe
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" javascript, html and css related settings
autocmd FileType javascript,htmldjango,html,css
  \ set tabstop=2     |
  \ set softtabstop=2 |
  \ set shiftwidth=2     
