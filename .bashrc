#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
set editing-mode vi
set show-mode-in-prompt On
# this enbles tab completion in sudo
complete -cf sudo
