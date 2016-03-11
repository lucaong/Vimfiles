Vimfiles
========

This repository contains my Vim setup, for my convenience when I switch machines
and for other people to make fun of it :P

It is intended to work on a Mac with terminal Vim version `7.3+`.

To check this out, backup your `.vimrc` and your `.vim`, then checkout the repo
and symlink `.vimrc`:

    git clone git://github.com/lucaong/Vimfiles.git ~/.vim
    ln -s ~/.vim/.vimrc ~/.vimrc
    cd ~/.vim
    git submodule init && git submodule update


## Updating plugins

Plugins are managed as git submodules. To update all of the to the latest
commit, run `./update_plugins` (and then commit and push the repo)
