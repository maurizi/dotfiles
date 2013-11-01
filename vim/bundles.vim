" Vundle (https://github.com/gmarik/vundle)
set nocompatible
filetype off

let g:vundle_default_git_proto = 'git'
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

" Solarized and airline both want 256 color
set t_Co=256

" NeoBundle manages itself
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

"Github
NeoBundle 'mileszs/ack.vim', {'external_commands': 'ack'}
NeoBundle 'bling/vim-airline'
    set laststatus=2
    set ttimeoutlen=50
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '◀'
    let g:airline_branch_prefix = '⎇  '
NeoBundle 'wincent/Command-T', {
\ 'disabled': !has('ruby'),
\ 'build' : {
\   'cygwin': 'cd ~/.vim/bundle/Command-T/ruby/command-t && ruby extconf.rb && make',
\   'unix': 'cd ~/.vim/bundle/Command-T/ruby/command-t && ruby extconf.rb && make',
\ }
\}
    nnoremap <silent> <Leader>t :CommandT<CR>
    nnoremap <silent> <Leader>f :CommandTBuffer<CR>
NeoBundle 'takac/vim-commandcaps'
NeoBundle 'sjl/gundo.vim'
    nnoremap <F5> :GundoToggle<CR>
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdtree'
    " Auto-open nerdtree when vim is opened without files,
    " and autoclose when it is the only thing left
    autocmd vimenter * if !argc() | NERDTree | endif
    autocmd bufenter *
        \   if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")
        \|      q
        \|  endif
    map <C-d> :NERDTreeToggle<CR>
    map <C-f> :NERDTreeFind<CR>
    " Single-click to open directories, double-click to open files
    let g:NERDTreeMouseMode=2
NeoBundle 'klen/python-mode'
    let g:pymode_lint=0
    let g:pymode_folding=0
NeoBundle 'tpope/vim-repeat'
NeoBundle 'altercation/vim-colors-solarized'
    let g:solarized_termcolors=256
NeoBundle 'maurizi/sparkup', {'rtp': 'vim/'}
    let g:sparkupMapsNormal=1
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/syntastic'
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_javascript_checkers=['jshint']
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_auto_loc_list=1
    let g:syntastic_loc_list_height=4
NeoBundle 'tpope/vim-fugitive'
    " Open Ggrep and Glog in a quickfix automatically
    nnoremap <leader>l :silent Glog \| redraw!<CR>
    autocmd QuickFixCmdPost *grep* cwindow
" vimscripts.org
NeoBundle 'tComment'
    " always put the comment in the first column
    let g:tcommentOptions = {'col':1}

filetype plugin indent on
NeoBundleCheck
