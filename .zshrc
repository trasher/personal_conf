# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
#zstyle ':completion:*' completer _complete _ignored _approximate

zstyle :compinstall filename '/home/trasher/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall
# This will set the default prompt to the walters theme
#prompt walters
# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhistory
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install
