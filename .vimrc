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

"Show tabs and trailing space
set list
set listchars=tab:>·,trail:␣

"Highlight matching )
set showmatch

" Use relative line numbers
set relativenumber

" Ignore case on search
set ignorecase
set smartcase

" Use standard Perl/Python regex syntax
nnoremap / /\v
vnoremap / /\v

" Highlight searches, disable highlights with \q
set incsearch
set hlsearch
nmap \q :nohlsearch<CR>

" Pathogen load
filetype off

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

set noerrorbells

" Save code folding state
set viewoptions-=options
augroup vimrc
    autocmd BufWinLeave *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview
    \|  endif
    autocmd BufWinEnter *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif
augroup END

" Move up/down by screen row not text line, useful for files with one REALLLY
" long line
nmap j gj
nmap k gk

set wrap
set textwidth=79
set formatoptions=qrn1

execute pathogen#infect()
execute pathogen#helptags()

filetype on
filetype plugin on
filetype plugin indent on
syntax on

" Python-mode https://github.com/klen/python-mode
let g:pymode_lint=0

" Linting provided by syntastic https://github.com/scrooloose/syntastic
let g:syntastic_python_checkers=['flake8']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=4

" Auto-close quickfix window when it's the only thing left
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" default highlighting sucks (white on yellow)
hi Search term=reverse ctermbg=11 ctermfg=000 guibg=Yellow guifg=Black

" Code completion for various web languages (CTRL+X -> CTRL+O to open)
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" have tComment https://github.com/tomtom/tcomment_vim always put the
" comment in the first column
let g:tcommentOptions = {'col':1}

" Remap commands for CommandT https://github.com/wincent/Command-T
nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <silent> <Leader>f :CommandTBuffer<CR>

" Auto-open nerdtree (https://github.com/scrooloose/nerdtree) when vim is
" opened without files, and autoclose when it is the only thing left
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter *
    \   if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")
    \|      q
    \|  endif
map <C-g> :NERDTreeToggle<CR>

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

" Mapping for gundo http://sjl.bitbucket.org/gundo.vim/
nnoremap <F5> :GundoToggle<CR>
