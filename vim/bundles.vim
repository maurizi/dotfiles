" Vundle (https://github.com/gmarik/vundle)
set nocompatible
filetype off

let g:vundle_default_git_proto = 'git'
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Vundle manages itself
Bundle 'gmarik/vundle'
"Github
Bundle 'mileszs/ack.vim'
Bundle 'bling/vim-airline'
Bundle 'wincent/Command-T'
Bundle 'takac/vim-commandcaps'
Bundle 'sjl/gundo.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-repeat'
Bundle 'altercation/vim-colors-solarized'
Bundle 'maurizi/vim-sparkup'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
" vimscripts.org
Bundle 'tComment'

filetype plugin indent on
