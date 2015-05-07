set nocompatible
filetype off

if has('vim_starting')
    set rtp+=$VIMHOME/bundle/neobundle.vim/
endif
call neobundle#begin(expand($VIMHOME.'/bundle/'))

" NeoBundle manages itself
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
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
    let g:airline_left_sep = '►'
    let g:airline_right_sep = '◄'
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    let g:airline_symbols.branch = 'λ'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'mapbox/carto', { 'rtp': 'build/vim-carto/' }
NeoBundle 'altercation/vim-colors-solarized'
    set t_Co=16
NeoBundle 'takac/vim-commandcaps'
NeoBundle 'maurizi/ctrlp.vim'
    let g:ctrlp_map = '<leader>t'
    " current buffers (default of <leader>b conflicts with py-mode)
    silent! nnoremap <unique> <silent> <Leader>f :CtrlPBuffer<CR>
    " tags
    silent! nnoremap <unique> <silent> <Leader>T :CtrlPTag<CR>
    " most recently used files
    silent! nnoremap <unique> <silent> <leader>m :CtrlPMRU<CR>
    let g:ctrlp_working_path_mode = ''  " Always search from current directory
    let g:ctrlp_show_hidden = 1
NeoBundle 'junegunn/vim-easy-align'
    vnoremap <silent> <Enter> :EasyAlign<Enter>
    vnoremap <silent> <Leader><Enter> :LiveEasyAlign<Enter>
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'int3/vim-extradite'
NeoBundle 'tpope/vim-fugitive'
    " Open Ggrep and Glog in a quickfix automatically
    nnoremap <leader>l :silent Glog \| redraw!<CR>
    autocmd QuickFixCmdPost *grep* cwindow
NeoBundle 'fatih/vim-go', {'external_commands': 'go'}
    let g:go_fmt_command = "gofmt"
NeoBundleLazy 'sjl/gundo.vim', {'autoload': {'commands': 'GundoToggle'}}
    nnoremap <F5> :GundoToggle<CR>
NeoBundle 'gabrielelana/vim-markdown'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdtree'
    map <C-a> :NERDTreeToggle<CR>
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
    let g:pymode_rope_regenerate_on_write = 0  " Need to find a way to do this in the background
NeoBundleLazy 'phildawes/racer', {
\ 'external_commands': 'cargo',
\ 'build' : {
\    'windows' : 'cargo build --release',
\    'cygwin' : 'cargo build --release',
\    'mac' : 'cargo build --release',
\    'unix' : 'cargo build --release',
\ },
\ 'autoload': {'filetypes': ['rust']}
\ }
NeoBundleLazy 'tpope/vim-repeat', {'autoload': {'mappings': '.'}}
NeoBundle 'wting/rust.vim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundleLazy 'rstacruz/sparkup', {
\ 'rtp': 'vim/',
\ 'autoload': {'filetypes': ['html', 'xml', 'htmldjango']}
\ }
    let g:sparkupMapsNormal=1
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'Shougo/neocomplete', {
\ 'disabled': !has('win32unix')
\ }
    let g:neocomplete#enable_at_startup = 1
NeoBundleLazy 'Valloric/YouCompleteMe', {
\ 'disabled': has('win32unix'),
\ 'build' : {
\     'mac' : 'git submodule update --init --recursive; ./install.sh --clang-completer --omnisharp-completer',
\     'unix' : 'git submodule update --init --recursive; ./install.sh --clang-completer --omnisharp-completer'
\    },
\ 'augroup': 'youcompletemeStart',
\ 'autoload': {'insert': 1}
\ }
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_key_list_previous_completion = ['<C-TAB>']
    let g:ycm_collect_identifiers_from_tags_files = 1
NeoBundle 'tpope/vim-surround'
NeoBundle 'mutewinter/swap-parameters'
NeoBundle 'benekastah/neomake'
    let g:neomake_python_enabled_makers=['flake8']
    let g:neomake_javascript_enabled_makes=['jshint']
    let g:neomake_open_list=1
    let g:neomake_list_height=4
    autocmd! BufWritePost * Neomake
NeoBundle 'majutsushi/tagbar'
NeoBundleLazy 'marijnh/tern_for_vim', {
\ 'external_commands': ['npm', 'node'],
\ 'autoload': {'filetypes': ['html', 'htmldjango', 'javascript']},
\ 'build' : {
\     'windows' : 'npm install',
\     'cygwin' : 'npm install',
\     'mac' : 'npm install',
\     'unix' : 'npm install'
\   }
\ }

" vimscripts.org
NeoBundle 'tComment'
    " always put the comment in the first column
    let g:tcommentOptions = {'col':1}
NeoBundleLazy 'AnsiEsc.vim', {'autoload': {'commands': 'AnsiEsc'}}
NeoBundle 'restore_view.vim'


call neobundle#end()

filetype plugin indent on
NeoBundleCheck
