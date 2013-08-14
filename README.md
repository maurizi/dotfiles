To use run
```
git clone git@github.com:maurizi/vim.git ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
cd ~/.vim && git submodule init && git submodule update
```

For ack.vim you need to install ```ack```
```
sudo apt-get install ack-grep
```

Command-t must be compiled in order to run, and requires ruby and a ruby compatible vim.
To install run:
```
  sudo apt-get install ruby-dev build-essential
  cd ~/.vim/bundle/command-t/ruby/command-t
  ruby extconf.rb
  make
```
