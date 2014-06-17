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
    let g:agprg="ag --column -U"
NeoBundle 'bling/vim-airline'
    set laststatus=2
    set ttimeoutlen=50
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '◀'
    let g:airline_branch_prefix = '⎇  '
NeoBundle 'altercation/vim-colors-solarized'
    let g:solarized_termcolors=256
NeoBundle 'takac/vim-commandcaps'
NeoBundle 'kien/ctrlp.vim'
    let g:ctrlp_map = '<leader>t'
    " current buffers (default of <leader>b conflicts with py-mode)
    silent! nnoremap <unique> <silent> <Leader>f :CtrlPBuffer<CR>
    " tags
    silent! nnoremap <unique> <silent> <Leader>T :CtrlPTag<CR>
    " most recently used files
    silent! nnoremap <unique> <silent> <leader>m :CtrlPMRU<CR>
    let g:ctrlp_working_path_mode = ''  " Always search from current directory
NeoBundle 'junegunn/vim-easy-align'
    vnoremap <silent> <Enter> :EasyAlign<Enter>
    vnoremap <silent> <Leader><Enter> :LiveEasyAlign<Enter>
NeoBundle 'maurizi/vim-easytags', {
\ 'external_commands': 'ctags',
\ 'depends': 'xolox/vim-misc',
\ 'focus': 1
\ }
    let g:easytags_by_filetype = $VIMHOME . '/ctags/'
    let g:easytags_auto_highlight = 0  " Disable highlighting because it is very slow
    let g:easytags_custom_ignore = '*/js/lib/*,*/js/shim/*,*/static/js/*'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'int3/vim-extradite'
NeoBundle 'tpope/vim-fugitive'
    " Open Ggrep and Glog in a quickfix automatically
    nnoremap <leader>l :silent Glog \| redraw!<CR>
    autocmd QuickFixCmdPost *grep* cwindow
NeoBundle 'jaxbot/github-issues.vim'
NeoBundleLazy 'sjl/gundo.vim', {'autoload': {'commands': 'GundoToggle'}}
    nnoremap <F5> :GundoToggle<CR>
NeoBundle 'embear/vim-localvimrc'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdtree'
    " Auto-open nerdtree when vim is opened without files,
    " and autoclose when it is the only thing left
    " Don't auto-open if we're in an embedded GVim (like eclim)
    if !exists("g:vimplugin_running")
        autocmd vimenter * if !argc() | NERDTree | endif
    endif
    autocmd bufenter *
        \   if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")
        \|      q
        \|  endif
    map <C-e> :NERDTreeToggle<CR>
    map <C-f> :NERDTreeFind<CR>
    " Single-click to open directories, double-click to open files
    let g:NERDTreeMouseMode=2
    " Use the same split opening bindings as ctrlp
    let g:NERDTreeMapOpenSplit='<C-s>'
    let g:NERDTreeMapOpenVSplit='<C-v>'
NeoBundle 'myusuf3/numbers.vim'
    let g:numbers_exclude = ['tagbar', 'gundo', 'nerdtree', 'ctrlp']
NeoBundle 'jvirtanen/vim-octave'
NeoBundleLazy 'klen/python-mode', {'autoload': {'filetypes': 'python'}}
    let g:pymode_lint=0
    let g:pymode_folding=0
    let g:pymode_rope_complete_on_dot=0 " Autocomplete is too slow and jarring to happen on a '.'
    let g:pymode_rope_rename_bind='<leader>r'
    let g:pymode_rope_goto_definition_bind = '<leader>j'
    let g:pymode_rope_regenerate_on_write = 1
NeoBundle 'tpope/vim-repeat'
NeoBundle 'derekwyatt/vim-scala'
NeoBundleLazy 'rstacruz/sparkup', {
\ 'rp': 'vim/',
\ 'autoload': {'filetypes': ['html', 'xml', 'htmldjango']}
\ }
    let g:sparkupMapsNormal=1
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'Valloric/YouCompleteMe', {
\ 'build' : {
\     'mac' : './install.sh --clang-completer --omnisharp-completer',
\     'unix' : './install.sh --clang-completer --omnisharp-completer'
\    }
\ }
    let g:EclimCompletionMethod = 'omnifunc'
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_key_list_previous_completion = ['<C-TAB>']
NeoBundle 'tpope/vim-surround'
NeoBundle 'mutewinter/swap-parameters'
NeoBundle 'scrooloose/syntastic'
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_javascript_checkers=['jshint']
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_auto_loc_list=1
    let g:syntastic_loc_list_height=4
    let g:syntastic_always_populate_loc_list=1 " Eclim forces me to do this. TODO: make Eclim behave
NeoBundle 'majutsushi/tagbar'
NeoBundle 'marijnh/tern_for_vim', {
\ 'external_commands': ['npm', 'node'],
\ 'autoload': {'filetypes': ['html', 'htmldjango', 'javascript']},
\ 'build' : {
\     'windows' : 'npm install',
\     'cygwin' : 'npm install',
\     'mac' : 'npm install',
\     'unix' : 'npm install'
\    }
\ }

" vimscripts.org
NeoBundle 'tComment'
    " always put the comment in the first column
    let g:tcommentOptions = {'col':1}
NeoBundleLazy 'AnsiEsc.vim', {'autoload': {'commands': 'AnsiEsc'}}

filetype plugin indent on
NeoBundleCheck
