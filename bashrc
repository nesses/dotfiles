# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
[[ $- != *i* ]] && return

google() {
	str=`echo $1 | sed 's/ /+/g'`;
	w3m "http://www.duckduckgo.com/lite/?q=$str";
}
__command_prompt() {	
	#LOG COMMANDS	
	COMMAND="$(history 1 | awk '{print substr($0, index($0,$2)) }' )"
	
	if [ -n "$HISTFILE" ];
	then
		echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $COMMAND" >> /var/log/bronko/bash-history-$(date "+%Y-%m-%d").log;
	fi

	#repeat update this variables
	if [ -n "$TMUX" ];
	then
		#export LINES="`tmux display -p '#{pane_height}'`";
		export COLUMNS="`tmux display -p '#{pane_width}'`";
	fi
	#tput sg0 causes in mess when zapping history
	#export PS1='$GREEN$BOLD[ \w ]----[ \t ]----[ \u@\h ]--[ L:$LINES C:$COLUMNS ]\n> \[\033[0m\]'
	export PS1='$GREEN$BOLD[ \w ]----[ \t ]----[ \u@\h ]--[ L:$LINES C:$COLUMNS ]\n> \[\033[0m\]'
}

##### COLORS ###########
export GREEN="$(tput setaf 2)"
export RED="$(tput setaf 1)"

export BOLD="$(tput bold)"

export PATH="$PATH:~/bin:.local/bin"
export HISTCONTROL=ignoreboth

if [ -n "$TMUX" ];
then
	export TERM="screen-256color";
else
	export TERM="xterm-256color"
fi

export PROMPT_COMMAND=__command_prompt



#make terminal transparent
[ -n "$WINDOWID" ] && [ -n "`pgrep -x xcompmgr`" ] && transset --id "$WINDOWID" 0.8 > /dev/null
# mc start in latest working dir
[ -f "/usr/bin/mc" ] && . /usr/libexec/mc/mc.sh


[ "$COLUMNS" -gt 73 ] && cat /home/bronko/shared/issue.scorpion || echo "Welcome back Commander!"


source /home/bronko/.bash_aliases



