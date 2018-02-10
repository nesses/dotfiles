# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

google() {
	str=`echo $1 | sed 's/ /+/g'`;
	w3m "http://www.duckduckgo.com/lite/?q=$str";
}
ddstat() {
	sudo kill -USR1 "$(pidof dd)"
}

# Put your fun stuff here.

#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent
#gpg-connect-agent updatestartuptty /bye > /dev/null


export TERM="xterm-256color"

[ -n "$TMUX" ] && export TERM="screen-256color"

export PATH="$PATH:/home/bronko/bin"
export HISTCONTROL=ignoreboth
#export DISPLAY=:0 

export PROMPT_COMMAND='if [ -n "$HISTFILE" ]; then  echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> /var/log/bronko/bash-history-$(date "+%Y-%m-%d").log; fi'
#export PROMPT_COMMAND="logbash"

[ -n "$WINDOWID" ] && [ -n "`pgrep -x xcompmgr`" ] && transset --id "$WINDOWID" 0.8 > /dev/null


# mc start in latest working dir
. /usr/libexec/mc/mc.sh

alias cls='clear'
alias ll='ls -alh'
alias htfm='mplayer http://isdn.ht-stream.net'
alias init='sudo init'

cat /home/bronko/shared/issue.scorpion
