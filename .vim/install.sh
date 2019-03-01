#!/bin/bash
cd ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
# Ubuntu 16.04 and later:
# sudo apt install build-essential cmake python3-dev
python3 install.py --clang-completer
