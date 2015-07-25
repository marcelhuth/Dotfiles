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
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
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

set autoindent
set smartindent

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set noexpandtab

set showmatch

set ruler

set hls

set incsearch

set number

set display=lastline

set shell=/bin/bash

set showfulltag
