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

setopt				\
	auto_cd 		\
	auto_pushd		\
	chase_links		\
	hist_verify		\
	complete_aliases	\
	hist_ignore_all_dups	\
	hist_ignore_space	\
	hist_verify		\
	share_history		\
	list_types		\
	extended_history	\
	append_history		\
	null_glob

setopt COMPLETE_IN_WORD

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=60

# Set grep to ignore SCM directories
if ! $(grep --exclude-dir 2> /dev/null); then
    GREP_OPTIONS="--color --exclude-dir=.svn --exclude=\*.pyc --exclude-dir=.hg --exclude-dir=.bzr --exclude-dir=.git"
else
    GREP_OPTIONS="--color --exclude=\*.svn\* --exclude=\*.pyc --exclude=\*.hg\* --exclude=\*.bzr\* --exclude=\*.git\*"
fi
export GREP_OPTIONS

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

#do not remove entire line on ctrl+u
bindkey '^u' backward-kill-line

# completion for PID
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*' force-list always
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors "$LS_COLORS"

#zstyle -e ':completion:*:(ssh|scp|sshfs|ping|telnet|nc|rsync):*' hosts '
#    reply=( ${=${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**} )'


#aliases
alias df='df -h'
alias dus='du -sh'

alias history='history -dDf'

function genpass() {
    if [ ! "$1" ]; then
        echo "Usage: $0 20"
        echo "For a random, 20-character password."
        return 1
    fi
    dd if=/dev/urandom count=1 2>/dev/null | tr -cd 'A-Za-z0-9!@#$%^&*()_+' | cut -c-$1
}

memtotaller() {
    /bin/ps -u $(whoami) -o pid,rss,command | awk '{sum+=$2} END {print "Total " sum / 1024 " MB"}'
}

# user specific zshrc
if [ -f $HOME/.zshrc-$(whoami) ]
then
  . $HOME/.zshrc-$(whoami)
fi

# automatically loads ulysses theme and .zsh_functions/VCS_Info directory are present
if [ -f $HOME/.zsh-ulysses-theme -a -d $HOME/.zsh_functions/VCS_Info ]
then
  . $HOME/.zsh-ulysses-theme
fi

#automaticaly load syntax highlighting if functions file is present
if [ -f $HOME/.zsh_functions/zsh-syntax-highlighting.zsh ]
then
  . $HOME/.zsh_functions/zsh-syntax-highlighting.zsh
fi
