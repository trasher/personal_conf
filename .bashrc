# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
export HISTCONTROL=ignoreboth
