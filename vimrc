" This must be first, because it changes other options as side effect

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

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
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
" Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'kien/rainbow_parentheses.vim'
" Plugin 'klen/python-mode'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-clojure-static'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
colorscheme zenburn
let g:airline_theme='ubaryd'
let mapleader=","
set encoding=utf-8 " Necessary to show Unicode glyphs
set clipboard=unnamedplus
set smartindent
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround
set nowrap
set textwidth=79
set colorcolumn=80
set formatoptions-=t
set cursorline
set number
set ruler
set wildmenu
set showcmd
set laststatus=2   " Always show the statusline
set showtabline=2  " Always display the tabline, even if there is only one tab
" With Vim Powerline hide the default mode text
" (e.g. -- INSERT -- below the statusline):
set noshowmode

set mouse=a
set bs=2 " make backspace behave like normal again
set wildignore+=*.pyc

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Highlight trailing whitespaces
" Available colors chart:
" http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
highlight ExtraWhitespace ctermbg=003
highlight ColorColumn ctermbg=008


" Setup symbols for airline
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" let g:airline_symbols.space = "\ua0"
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'
" Edit .vimrc
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
" Apply changes in .vimrc
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" File tree viewer (Ctrl+n to toggle):
noremap <C-n> :NERDTreeToggle<CR>

" Deal with duplicating the text
" map <C-d> yyp<Esc>     " Dulicate current line
" vmap <C-d> y'>p<Esc>   " Duplicate selection
noremap <Leader>d yyp<Esc>   " Dulicate current line
vnoremap <Leader>d y'>p<Esc> " Duplicate selection

" Easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Deal with tabs
noremap <Leader>t :tabnew<Esc>          " Open new tab
noremap <Leader>tc :tabclose<Esc>       " Close current tab
noremap <Leader>, <Esc>:tabnext<CR>     " Navigate to the next tab
noremap <Leader>. <Esc>:tabprevious<CR> " Navigate to the previous tab
vnoremap <Leader>s :sort<CR>            " Sort selected lines (e.g. imports)

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase

" Bind nohl (remove hilighted results of last search)
noremap <Leader>h :nohl<CR>

" Bind Ctrl+<movement> to move between windows (splits), instead of using
" <C+w>+<movement>
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h


" Settings for ctrlp
" ===================
let g:ctrlp_max_height = 30

" Settings for pymode
" ===================

" Enable automatic virtualenv detection         *'g:pymode_virtualenv'*
let g:pymode_virtualenv = 1
let g:pymode_folding = 1
let g:pymode_python = 'python3'
