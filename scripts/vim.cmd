chdir /D %~dp0

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

FOR /F "delims=" %%i IN ('git rev-parse --show-toplevel') DO set DOTFILES=%%i

set BASE_DIR=%DOTFILES%/unix

call mklink "%HOME%/_vimrc" "%BASE_DIR%/.vimrc"
call mklink /J "%HOME%/vimfiles" "%BASE_DIR%/.vim"
call mklink "%HOME%/.vagrant.d/Vagrantfile" "%BASE_DIR%/.vagrant.d/Vagrantfile"

IF NOT EXIST "%BASE_DIR%/vim/bundle" (
        call mkdir "%BASE_DIR%/vim/bundle"
)

IF NOT EXIST "%HOME%/vim/bundle/neobundle.vim" (
    call git clone git://github.com/Shougo/neobundle.vim.git "%BASE_DIR%/bundle/neobundle.vim"
)

PAUSE
