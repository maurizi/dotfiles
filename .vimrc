" Use Vim, not Vi settings
set nocompatible

"Tab settings
set shiftwidth=4
set softtabstop=4
set tabstop=4

"Insert spaces for tabs
set expandtab

"Autoindent (maybe try smartindent?)
set autoindent
set smarttab
set copyindent
set preserveindent

" Set F2 to toggle indent fixing for pasting
set pastetoggle=<F2>

set backspace=indent,eol,start

"Show tabs and tailing space
set list
set listchars=tab:>.,trail:.

"Highlight matching )
set showmatch

" Pathogen load
filetype off

execute pathogen#infect()
execute pathogen#helptags()

filetype on
filetype plugin on
filetype plugin indent on
syntax on

" Python-mode https://github.com/klen/python-mode
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_minheight = 1

" JS linting w/ JSHint on save https://github.com/Shutnik/jshint2.vim
let g:jshint2_save = 1

" Code completion for various web languages (CTRL+X -> CTRL+O to open)
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Remap commands for CommandT https://github.com/wincent/Command-T
nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <silent> <Leader>f :CommandTBuffer<CR>

" Settings for airline (lightweight powerline)
" https://github.com/bling/vim-airline
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
set laststatus=2
set ttimeoutlen=50
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_branch_prefix = '⎇  '

" Set html files to have 2 space tabs
augroup myHtml
    au!
    au FileType html,htmldjango setlocal ts=2
    au FileType html,htmldjango setlocal sts=2
    au FileType html,htmldjango setlocal sw=2
augroup END

" Backups/temp files in single directory
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Ignore case on search
set ignorecase
set smartcase

" Highlight searches, disable highlights with \q
set incsearch
set hlsearch
nmap \q :nohlsearch<CR>

set noerrorbells

" Save code folding state
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Map W and Q to w and q for typos
command W w
command Q q
command WQ wq
command Wq wq

" Move up/down by screen row not text line, useful for files with one REALLLY
" long line
nmap j gj
nmap k gk
