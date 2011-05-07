# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
#zstyle ':completion:*' completer _complete _ignored _approximate

zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhistory
HISTSIZE=50000
SAVEHIST=50000
#do not save entries that begin with a space in the history
setopt HIST_IGNORE_SPACE
#do not store duplicate entries in the history
setopt hist_ignore_all_dups
#access to the current history from multiple shells
setopt appendhistory
#add date and duration to history entries
setopt EXTENDED_HISTORY

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

#emacs key binding
bindkey -e
# End of lines configured by zsh-newuser-install

# fix delete key annoyances
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey ' ' magic-space # magic is awesome!

# crtl+right arrow and crtl+left arrow
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word

# fix home/end keys
bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kend] end-of-line

# completion for PID
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*' force-list always
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# user specific zshrc
if [ -f $HOME/.zshrc-$(whoami) ]
then
  . $HOME/.zshrc-$(whoami)
fi
