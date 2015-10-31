"""""""""""""""""""""""""""""""""""""
"" Marcel's .vimrc
""
"" based on:
""	https://github.com/trulleberg/Dotfiles/
"""""""""""""""""""""""""""""""""""""

" Be not compatible to VI, required
set nocompatible
" Required
filetype off
" ---------------------------
" Vundle setup
" ---------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Template Plugin
Plugin 'scrooloose/nerdtree'
" Syntax for Doccker files
"Plugin 'ekalinin/Dockerfile.vim'
" Vim Markdown syntax hightlight
Plugin 'godlygeek/tabular'
" Vim markdown syntax highlighting
Plugin 'plasticboy/vim-markdown'
" Git plugins
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Syntax highlight, indention for Puppet language
Plugin 'rodjek/vim-puppet'
" Better status line
Plugin 'bling/vim-airline'
" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ---------------------------
" NERDTree
" ---------------------------
" Open NERDTree when no file is spcified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" CTRL N Toggles NERDTree
"map <silent> <C-n> :NERDTreeFocus<CR>
map <silent> <C-n> :NERDTreeToggle<CR>
" Close vim if NERDTree is the last windows
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ---------------------------
" Theme
" ---------------------------
" Support for 256 colors
set t_Co=256
" Enable syntax highlighting
syntax enable
" Light background for Solarized theme
set background=light
colorscheme solarized
" Enable background toggling for solarized theme
call togglebg#map("<F5>")

" ---------------------------
" General Settings
" ---------------------------
" Remember the last 1000 lines as history
set history=1000
" Support all three, in this order
set ffs=unix,mac,dos
" Remove this chars as word delimiters
set isk+=_,$,@,%,#
" Leave the cursor where it was
set nosol

" ---------------------------
" UI Settings
" ---------------------------

" Only in GUI mode: Do not add linespace
set lsp=0
" Turn on wildmenu. Command completition
set wildmenu
set wildmode=list:longest
" Do not complete the following:
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png
" Show current position at the bottom
set ruler
" Command prompt is 1 line height
set cmdheight=1
" Show line numbering
set number
" Let BS work like in other apps
set backspace=indent,eol,start
" Cursor keys wrap to next line
set whichwrap+=<,>,[,]
" Enable the mouse everywhere
set mouse=a
" Shorter messages, see :help 'shortmess
set shortmess=atI
" Always report changed lines
set report=0
" Be quiet
set noerrorbells
" Show tabs, white-spaces and so on
set list
set listchars=tab:»·,trail:·,precedes:«,extends:»
" Put new split windows below / right to the current one
" Show matching brackets for 5/100 seconds (default)
set showmatch
set mat=5
" Do not hightlight all search results
set nohlsearch
" Do hightlight as you type the search phrase
set incsearch
" Keep 5 lines above and below the cursor when moving
set scrolloff=5
" Do not blink
set novisualbell
" Always show status line
set laststatus=2

" ---------------------------
" Split settings
" ---------------------------

set splitbelow
set splitright
" Remap some keys to get the navigation easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ---------------------------
" Indention settings
" ---------------------------
set autoindent
set nosmartindent
" C-sytel indention
set cindent
" Use what is in the file before when changing indention
set copyindent
" Use what is in the file before when changing indention
set preserveindent
" Round indention to multiples of shiftwidth when using > or <
set shiftround
" Use defined filetype indention
filetype plugin indent on

" Set text formatting (default), see :help 'fo
set formatoptions=tcq
set softtabstop=2
set shiftwidth=2
set tabstop=2
" Use spaces instead of tabs
set expandtab

" Wrap lines
set wrap

" Ignore case when searching
set ignorecase
" If there are caps in the search string, use noignorecase
set smartcase
" Improve autocomplete
set completeopt=menu,longest,preview
" Mark current cursor line (cul) or cursor column (cuc)
"set cuc
"set cul
" Set the textwidth for the soft wrap (tw)
set textwidth=80

" ---------------------------
" Spell checking
"  Spellchecking works with the automatically downloaded files.
"  If there is a problem with files (VIM error message during startup
"  on a Mac, please rm /usr/share/vim/vim73/spell/en.* files and
"  let VIM download the files to ~/.vim/spell automatically.
" ---------------------------
" Do not automatically enable spell checking for all files
"set spell
" Set spell language to English (US) and German (new)
set spelllang=en_us,de_20
" Enable spellchecking for markdown, txt and tex files automatically
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.txt set filetype=text
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd FileType markdown setlocal spell
autocmd FileType text setlocal spell
autocmd FileType tex setlocal spell
" ---------------------------
" Encoding
" ---------------------------
set enc=utf-8

" ---------------------------
" Folding
"   Like trulleberg, folding is primarily annoying. In some case 
"   it could be helpful. So we behave like folding is disabled, but
"   it's possible to enable it.
" ---------------------------
set foldenable
set foldmarker={,}
set foldmethod=marker
" Don't autofold to much (still possible manually)
set foldlevel=100
" Don't open folds when searching or undoing stuff
set foldopen-=search
set foldopen-=undo

" ---------------------------
"  Airline
" ---------------------------
" Enable usage of Powerline fonts, I use "Hacks" which works fine
" on the Mac
let g:airline_powerline_fonts = 1
" Enable the git branch and hunks outputs in airline
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1
" Disable the whitespace checking
let g:airline#extensions#whitespace#enabled=0
" Enable tab bar extension
let g:airline#extensions#tabline#enabled = 1
