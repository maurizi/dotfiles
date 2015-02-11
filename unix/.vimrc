scriptencoding utf-8
set encoding=utf-8
" Use Vim, not Vi settings
set nocompatible

if has('win32') || has ('win64')
    let $VIMHOME=expand("~/vimfiles")
else
    let $VIMHOME=expand("~/.vim")
endif

filetype off

" Set html files to have 2 space tabs
augroup myHtml
    au!
    au FileType html,htmldjango setlocal ts=2
    au FileType html,htmldjango setlocal sts=2
    au FileType html,htmldjango setlocal sw=2
augroup END

source $VIMHOME/bundles.vim
silent! source $VIMHOME/secret.vim
syntax on

" Source local vim files
set exrc
set secure

" Better window movement
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

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
map <F2> :set invpaste<cr>

nnoremap <S-Insert> "+p
inoremap <S-Insert> <C-r>+
nnoremap <S-y> "+y
vnoremap <S-y> "+y

set backspace=indent,eol,start

set scrolloff=3

"Show tabs and trailing space
set list
set listchars=tab:>·,trail:␣

"Highlight matching )
set showmatch

" relative line numbers
if exists('+relativenumber')
    set relativenumber
endif
if version >= 704
    set number
endif

" Ignore case on search
set ignorecase
set smartcase

" Highlight searches, disable highlights with \q
set incsearch
set hlsearch
nmap \q :nohlsearch<CR>

" Backups/temp/undo files in single directory
set backup
set backupdir=$VIMHOME/backup
set directory=$VIMHOME/tmp
set viewdir=$VIMHOME/view
if has('persistent_undo')
    set undofile
    set undodir=$VIMHOME/undo
    set undolevels=300
endif

set noerrorbells

set foldmethod=indent
set foldnestmax=1
set foldlevelstart=0
set foldlevel=0

" Move up/down by screen row not text line, useful for files with one REALLLY
" long line
nmap j gj
nmap k gk

" Map tab and shift-tab to next/prev in location fix, useful for syntastic and Ag
function! NextInLocationOrQuickFix(dir)
  if IsBufferOpen("Location List")
    silent! exec('l'.a:dir)
  elseif IsBufferOpen("Quickfix List")
    silent! exec('c'.a:dir)
  endif
endfunction
nnoremap <silent> <tab> :call NextInLocationOrQuickFix('next')<CR>
nnoremap <silent> <S-tab> :call NextInLocationOrQuickFix('prev')<CR>

set wrap
set textwidth=79
set formatoptions=qrn1

" Delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Paste without yanking
nnoremap <leader>p "_dP
vnoremap <leader>p "_dP

" Ignore the obvious things (also affects CtrlP when installed)
set wildignore+=*.o,*.obj,*.pyc,*/node_modules/*,*.min.js

" Mouse usage enabled in normal mode.
set mouse=n
" " Set xterm2 mouse mode to allow resizing of splits
set ttymouse=xterm2

" Auto-close quickfix window when it's the only thing left
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Toggle quickfix, From:
" vim.wikia.comwiki/Toggle_to_open_or_close_the_quickfix_window
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! IsBufferOpen(bufname)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      return 1
    endif
  endfor
  return 0
endfunction

function! ToggleList(bufname, pfx)
  if IsBufferOpen(a:bufname)
    exec(a:pfx.'close')
    return
  endif
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" I don't know why, but I need this for <C-q> to be aqble to be mapped
silent !stty -ixon > /dev/null 2>/dev/null
nnoremap <silent> <C-l> :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <C-q> :call ToggleList("Quickfix List", 'c')<CR>

" Autoload vimrc changes
augroup vimrc
    au!
    au BufWritePost $MYVIMRC so $MYVIMRC
    au BufWritePost vimrc so $MYVIMRC
    au BufWritePost bundles.vim so $MYVIMRC
augroup END

" default highlighting sucks (white on yellow)
hi Search term=reverse ctermbg=11 ctermfg=000 guibg=Yellow guifg=Black

" Code completion for various web languages (CTRL+X -> CTRL+O to open)
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType octave set omnifunc=syntaxcomplete#Complete

" Solarized needs to happen in vimrc for some reason...
set background=dark
colorscheme solarized
