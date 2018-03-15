# /etc/skel/.bashrc

#interactive || die
[[ $- != *i* ]] && return

#init
source ~/.bash_colors
source ~/.bash_func
source ~/.bash_aliases
#,,,
#
#environment
export PATH="$PATH:~/bin:~/.local/bin"
export HISTCONTROL=ignoreboth
export DISPLAY=:0
#,,,

#overwrite/create XDG user directories
#export XDG_CONFIG_HOME="~/.config/"
#export XDG_CACHE_HOME="~/.cache/"
#,,,


#BSPWM::make terminal transparent
[ -n "$WINDOWID" ] && [ -n "`pgrep -x xcompmgr`" ] && transset --id "$WINDOWID" 0.92 > /dev/null
#,,,

#greeting and prompt
cat ~/shared/issue.scorpion

__command_prompt() {	
	#LOG COMMANDS	
	COMMAND="$(history 1 | awk '{print substr($0, index($0,$2)) }' )"
	
	if [ -n "$HISTFILE" ];
	then
		echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $COMMAND" >> /var/log/bronko/bash-history-$(date "+%Y-%m-%d").log;
	fi

	#export PS1='$BLUE$BOLD[ \w ]----[ \t ]----[ \u@\h ]--[ L:$LINES C:$COLUMNS ]\n> \[\033[0m\]'
	export PS1='\[$BLUE$BGWHITE$BOLD\]   \t \[$WHITE$BGBLUE\]   \h \[$BLUE$BGDARKGRAY\]\[$BGDARKGRAY$WHITE\] $(pwd | sed "s\/\  \g") \[$DARKGRAY$BGBLACK\]\n\[$BGWHITE$BLUE\]   \u \[$WHITE$BGBLACK\]\[\033[00m\] '
}

export PROMPT_COMMAND=__command_prompt
#,,,





