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

########## COLORS ###########
GREEN="$(tput setaf 2)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"

google() {
	str=`echo $1 | sed 's/ /+/g'`;
	w3m "http://www.duckduckgo.com/lite/?q=$str";
}
ddstat() {
	sudo kill -USR1 "$(pidof dd)"
}
logger() {	
	FILTER="exit;tmux;tmux a;alsamixer;alsamixer -Dhw;ls;cd"	
	
	COMMAND="$(history 1 | awk '{print substr($0, index($0,$2)) }' )"
	
	FILTER=`echo "$FILTER" | sed 's/;/\n/g'`

	while read -r i;
	do	
		[ "$COMMAND" == "$i" ] || [ "$COMMAND" == "$i " ] && return;
	done <<< $FILTER
	
	if [ -n "$HISTFILE" ];
	then
		echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $COMMAND" >> /var/log/bronko/bash-history-$(date "+%Y-%m-%d").log;
	fi
}

#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent
#gpg-connect-agent updatestartuptty /bye > /dev/null


export TERM="xterm-256color"

[ -n "$TMUX" ] && export TERM="screen-256color"

export PATH="$PATH:/home/bronko/bin"
export HISTCONTROL=ignoreboth

export PROMPT_COMMAND='logger'

#export PS1="$GREEN[ \w ]----[ \t ]----[ \u@\h ]--[ $(awk '/MemFree/{print $2}' /proc/meminfo ) ]\n> $RESET"
export PS1='$GREEN$BOLD[ \w ]----[ \t ]----[ \u@\h ]--[ L:$LINES C:$COLUMNS ]\n> $RESET'

[ -n "$WINDOWID" ] && [ -n "`pgrep -x xcompmgr`" ] && transset --id "$WINDOWID" 0.8 > /dev/null


# mc start in latest working dir
. /usr/libexec/mc/mc.sh

cat /home/bronko/shared/issue.scorpion

alias cls='clear'
alias ll='ls -alh'
alias htfm='mplayer http://isdn.ht-stream.net'
alias init='sudo init'
alias usdo='sudo'
alias mouseoff='synclient touchpadoff=1'
alias mouseon='synclient touchpadoff=0'
alias tputls='for C in {0..255};do tput setab $C;echo -n "$C ";done;tput sgr0;echo'
alias vibash='vim ~/.bashrc'





