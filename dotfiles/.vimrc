" This must be first, because it changes other options as side effect

set nocompatible              " be iMproved, required
filetype off                  " required


" Settings for ctrlp
" ===================
let g:ctrlp_max_height = 30

" Setup some default ignores for ctrlp
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](\.(git|hg|svn|eggs|cache)|\_site|htmlcov)$',
\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
" In ctrlp use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Python settings:

" Install Plugins
call plug#begin('~/.vim/plugged')
" Keep Plug commands between plug#begin/end.

" The following are examples of different formats supported.
" plugin on GitHub repo
" Plug 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plug 'L9'
" Git plugin not hosted on GitHub
" Plug 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plug 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plug 'user/L9', {'name': 'newL9'}
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'

" Tagbar plug-in requires ctags: http://ctags.sourceforge.net/
" In Fedora just run `sudo dnf install ctags`
Plug 'preservim/tagbar'


" Airline - status bar for Vim:
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'kien/ctrlp.vim'
" Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'kien/rainbow_parentheses.vim'
" Plug 'klen/python-mode'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'fatih/vim-go'
Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'
"Plug 'guns/vim-clojure-static'
Plug 'davidhalter/jedi-vim'


" Markdown
Plug 'tpope/vim-markdown'
Plug 'jtratner/vim-flavored-markdown'

" Markdown preview
" pip install grip
Plug 'JamshedVesuna/vim-markdown-preview'

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_temp_file=1

" Grep files
" Prerequisites:
" sudo dnf install ripgrep
" See: https://github.com/BurntSushi/ripgrep#installation
Plug 'jremmen/vim-ripgrep'

" All of your Plugins must be added before the following line
call plug#end()            " required

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

" Jedi autocomplete
autocmd FileType python setlocal completeopt-=preview


"Settings for Vim Airline
" ================
let g:airline_theme='zenburn'
let g:airline_powerline_fonts = 1

" Settings for ctrlp
" ===================
let g:ctrlp_max_height = 30

" Setup some default ignores for ctrlp
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](\.(git|hg|svn|eggs|cache)|\_site|htmlcov)$',
\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
" In ctrlp use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Python settings:
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype python setlocal foldmethod=indent

" YAML files:
autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

let mapleader=","
set encoding=utf-8 " Necessary to show Unicode glyphs
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
set re=0
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

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase
set shortmess-=S    " show N/M while searching

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Show white spaces
set listchars=eol:¬
set listchars=tab:┊\ 
set list
" make Esc happen without waiting for timeoutlen
" fixes Powerline delay
if ! has('gui_running')
set ttimeoutlen=10
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END
endif

" Highlight trailing whitespaces
" Available colors chart:
" http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
highlight ExtraWhitespace ctermbg=003
highlight ColorColumn ctermbg=008

" Settings for Rainbow Parentheses
let g:rbpt_colorpairs = [
\ ['brown',       'RoyalBlue3'],
\ ['Darkblue',    'SeaGreen3'],
\ ['darkgray',    'DarkOrchid3'],
\ ['darkgreen',   'firebrick3'],
\ ['darkcyan',    'RoyalBlue3'],
\ ['darkred',     'SeaGreen3'],
\ ['darkmagenta', 'DarkOrchid3'],
\ ['brown',       'firebrick3'],
\ ['gray',        'RoyalBlue3'],
\ ['black',       'SeaGreen3'],
\ ['darkmagenta', 'DarkOrchid3'],
\ ['Darkblue',    'firebrick3'],
\ ['darkgreen',   'RoyalBlue3'],
\ ['darkcyan',    'SeaGreen3'],
\ ['darkred',     'DarkOrchid3'],
\ ['red',         'firebrick3'],
\ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

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


vnoremap <Leader>s :sort<CR>            " Sort selected lines (e.g. imports)

" Deal with tabs
noremap <Leader>t :tabnew<Esc>          " Open new tab
noremap <Leader>tc :tabclose<Esc>       " Close current tab
" noremap <Leader>, <Esc>:tabnext<CR>     " Navigate to the next tab
" noremap <Leader>. <Esc>:tabprevious<CR> " Navigate to the previous tab


" Deal with buffers
nmap <Leader>b :enew<Esc>          " Open new buffer
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>          " Close current buffer
nmap <Leader>, <Esc>:bnext<CR>     " Navigate to the next buffer
nmap <Leader>. <Esc>:bprevious<CR> " Navigate to the previous buffer
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Bind nohl (remove hilighted results of last search)
noremap <Leader>h :nohl<CR>

" Bind Ctrl+<movement> to move between windows (splits), instead of using
" <C+w>+<movement>
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

" Ripgrep hot key
nnoremap <F4> :Rg<Space>
let g:rg_highlight = 'true'


" Plugins

" Tagbar
nnoremap <F8> :TagbarToggle<CR>
