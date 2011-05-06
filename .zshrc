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
setopt HIST_IGNORE_SPACE
setopt hist_ignore_all_dups
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install

# fix delete key annoyances
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey ' ' magic-space # magic is awesome!

## key bindings - not sure it's usefull for me
#bindkey ';5D' emacs-backward-word
#bindkey ';5C' emacs-forward-word

# fix home/end keys
bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kend] end-of-line

