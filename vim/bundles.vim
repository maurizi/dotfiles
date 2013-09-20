" Vundle (https://github.com/gmarik/vundle)
set nocompatible
filetype off

let g:vundle_default_git_proto = 'git'
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

" NeoBundle manages itself
NeoBundleFetch 'gmarik/vundle'
NeoBundle 'Shougo/vimproc'

"Github
NeoBundle 'mileszs/ack.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'wincent/Command-T'
NeoBundle 'takac/vim-commandcaps'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'klen/python-mode'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'maurizi/sparkup', {'rtp': 'vim/'}
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
" vimscripts.org
NeoBundle 'tComment'

filetype plugin indent on
NeoBundleCheck
