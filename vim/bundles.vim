set nocompatible
filetype off

set rtp+=$VIMHOME/bundle/neobundle.vim/
call neobundle#rc(expand($VIMHOME.'/bundle/'))

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
\    }
\ }

"Github
NeoBundle 'rking/ag.vim', {'external_commands': 'ag'}
NeoBundle 'bling/vim-airline'
    set laststatus=2
    set ttimeoutlen=50
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '◀'
    let g:airline_branch_prefix = '⎇  '
NeoBundle 'kien/ctrlp.vim'
    let g:ctrlp_map = '<leader>t'
    " current buffers (default of <leader>b conflicts with py-mode)
    silent! nnoremap <unique> <silent> <Leader>f :CtrlPBuffer<CR>
    " tags
    silent! nnoremap <unique> <silent> <Leader>T :CtrlPTag<CR>
    " most recently used files
    silent! nnoremap <unique> <silent> <leader>m :CtrlPMRU<CR>
    let g:ctrlp_working_path_mode = ''  " Always search from current directory
NeoBundle 'takac/vim-commandcaps'
NeoBundle 'maurizi/vim-easytags', {
\ 'external_commands': 'ctags',
\ 'depends': 'xolox/vim-misc'
\ }
    let g:easytags_by_filetype = $VIMHOME . '/ctags/'
    let g:easytags_auto_highlight = 0  " Disable highlighting because it is very slow
    let g:easytags_custom_ignore = '*/js/lib/*,*/js/shim/*,*/static/js/*'
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
    " Use the same split opening bindings as ctrlp
    let g:NERDTreeMapOpenSplit='<C-s>'
    let g:NERDTreeMapOpenVSplit='<C-v>'
NeoBundle 'klen/python-mode'
    let g:pymode_lint=0
    let g:pymode_folding=0
NeoBundle 'tpope/vim-repeat'
NeoBundle 'altercation/vim-colors-solarized'
    let g:solarized_termcolors=256
NeoBundle 'maurizi/sparkup', {'rtp': 'vim/'}
    let g:sparkupMapsNormal=1
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'junegunn/vim-easy-align'
    vnoremap <silent> <Enter> :EasyAlign<Enter>
    vnoremap <silent> <Leader><Enter> :LiveEasyAlign<Enter>
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
