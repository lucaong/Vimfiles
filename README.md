Vimfiles
========

This repository contains my Vim setup, for my convenience when I switch machines and
for other people to take inspiration (dude, really?).

It is intended to work on a Mac with terminal Vim version `7.3+`.

To check this out, backup your `.vimrc` and your `.vim`, then checkout the repo and symlink `.vimrc`:

    git clone git://github.com/lucaong/Vimfiles.git ~/.vim
    ln -s ~/.vim/.vimrc ~/.vimrc
    cd ~/.vim
    ./setup_plugins

You might also need to create the directory where swap and backup files are created:

    mkdir -p ~/.vim-tmp
