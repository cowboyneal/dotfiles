# Bash knows 3 diferent shells: normal shell, interactive shell, login shell.
# ~/.bashrc is read for interactive shells and ~/.profile is read for login
# shells. We just let ~/.profile also read ~/.bashrc and put everything in
# ~/.bashrc.

# Internal functions
exists () { # returns true if $1 is an executable file in our path
	local exe=`type -path -all "$1" | head -n 1`
	[ -x "$exe" ]
}
# end of internal functions

# Set up path carefully
PATH=~/bin					# script overrides for EoU
PATH=$PATH:/usr/local/bin:/usr/local/sbin	# local first for mit k5
PATH=$PATH:/bin:/usr/bin:/usr/games		# usual path
PATH=$PATH:/sbin:/usr/sbin			# sudo/root stuff

[ -d /opt/local/share/man ] && export MANPATH=$MANPATH:/opt/local/share/man

# Determine host type
UNAME=`uname`

case $UNAME in
	Darwin* )
		PATH=/opt/local/bin:/opt/local/sbin:$PATH
		unset PROMPT_COMMAND
		;;
	CYGWIN* )
		PATH=$PATH:/cygdrive/c/Windows/system32:/cygdrive/c/Windows
		PATH=$PATH:/cygdrive/c/Windows/System32/Wbem
		PATH=$PATH:/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0/
		PATH="$PATH:/cygdrive/c/Program Files (x86)/MIT/Kerberos/bin"
		;;
esac
export PATH
export CDPATH=.:..

# set pager smartly
if exists less; then
	PAGER=less
	export LESS='-ir'
    export LESSOPEN='|~/.lessfilter %s'
	alias 'more'='less'
else
	PAGER=more
fi
export PAGER

# set editor smartly
if exists vim; then
	EDITOR=vim
	alias 'view'='vim -R' # for read-only!
elif exists nvi; then
	EDITOR=nvi
else
	EDITOR=vi
fi
export EDITOR

set -o vi
set -o ignoreeof
set -o notify

shopt -s cdspell
shopt -s checkwinsize
shopt -s hostcomplete
[ "${BASH_VERSINFO[0]}" -gt 3 ] && shopt -s dirspell

umask 022
unset MAILCHECK
unset TMOUT

# commands common to all logins
if [ -z "$TERM" ]; then
    eval `tset -s -Q`
    [[ "$TERM" =~ con|vt100 ]] && tset -Q -e ^?
fi

# Some programs support several languages for their output.
# If you want them to use english, please uncomment the following line.
#export LANG='en_US.UTF-8'

# try to set DISPLAY smart
if [ -z "$DISPLAY" ] && [[ "$TERM" =~ xterm|rxvt ]] && [ -n "$SSH_CLIENT" ];
then
	export DISPLAY="`echo $SSH_CLIENT | awk '{ print $1 }'`:0.0"
fi

# Make BSD look like GNU
[[ "$UNAME" =~ BSD|Darwin ]] && export LSCOLORS=ExGxFxdxCxDxDxhbadExEx

export COLORFGBG='lightgray;black'

# prompt stuff
color1="\[\033[0;34m\]" # unused
color2="\[\033[1;34m\]" # blue
color3="\[\033[0;37m\]" # unused
color4="\[\033[0m\]"    # default

PS1="$color4[$color2\!$color4] $color2\h $color4:$color2 \w$color4 "

if exists git && [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    PS1=$PS1'$(__git_ps1 "(\[\033[1;34m\]%s\[\033[0m\]) ")'
fi

case `/usr/bin/whoami` in
  root* ) PS1=$PS1'# ' ;;
  * ) PS1=$PS1"\$ " ;;
esac

PS1=$PS1$color4
unset color1 color2 color3 color4

if [[ "$TERM" =~ xterm|rxvt|screen ]]; then
    PS1="\[\033]0;[ \u @ \h ] - "`tty | sed 's!/dev/!!'`" : \w\007\]$PS1"
fi

export PS1 PS2
export PROMPT_DIRTRIM=3

# Set aliases proper. Uncomment the following line to pull in more external
# aliases.
#test -e ~/.alias && . ~/.alias

alias 'reload'='source ~/.bashrc'

case $UNAME in
	*BSD | Darwin* )	lsopts='-GF' ;;
	Linux | CYGWIN* )	lsopts='--color=auto -F' ;;
	* )			lsopts='-F' ;;
esac

alias 'ls'="ls $lsopts"
alias 'la'='ls -a'
alias 'll'='la -l'
alias 'lh'='ll -h'
unset lsopts

alias 'df'='df -h'
alias 'du'='du -h'
alias 'h'='history'
alias 'j'='jobs -l'
alias 'xon'='ssh -X'
alias 'nuke'='kill -9'
alias 'cdd'='cd $OLDPWD'
alias 'psme'="ps x | $PAGER"
alias 'pss'="ps aux | $PAGER"
alias 'grep'='grep --color=auto'
alias 'egrep'='egrep --color=auto'
alias 'fgrep'='fgrep --color=auto'

exists tmux && alias 'tmux'='tmux attach -d'

if exists irssi; then
	alias 'irc'='irssi'
	exists dtach && alias 'irssi'="dtach -A /tmp/${USER}-irssi irssi"
fi

exists mutt && alias 'mail'='mutt'
exists kftp && alias 'ftp'='kftp'
exists vncserver && alias 'vnc'='vncserver -geometry 1280x1024 -depth 24'
exists emacs && alias 'dunnet'='emacs -batch -l dunnet'
exists qw-server && exists dtach && alias 'qwsv'="dtach -A /tmp/${USER}-qwsv qw-server +gamedir ctf"

if [[ "$TERM" =~ screen ]]; then
	exists vim && alias 'vim'='vim -T xterm'
	exists w3m && alias 'w3m'='w3m -title=xterm'
fi

# Portability vars
bsd1=
bsd2=

if [[ "$UNAME" =~ BSD|Darwin ]]; then
	bsd1=-
	bsd2="${bsd1}p "
fi

# Shell Functions, because copying tiny scripts sucks, amirite
slay () { # What we used on Solaris because killall killed all procs
  local p
  for p in `ps ${bsd1}axc -o pid= -o command= | awk /"$1"/'{print $1}'`; do
    kill $p
  done
}

got () { # got <process name>?
  local proc=${1%\?}
  local pids=$( ps ${bsd1}axc -o pid= -o command= | awk /"$proc"/'{print $1}' )
  if [ -n "$pids" ]; then
    ps w ${bsd2}$pids
  else
    echo "$proc not found"
  fi
}

# IRC stuff
if exists epic || exists BitchX || exists bitchx || exists ircii; then
	export EMAIL=cowboyneal@gmail.com
	export IRCNICK=CowboyNeal
	export IRCSERVER=us.slashnet.org
	export IRCPORT=6667
fi

# CVS stuff
if exists cvs; then
	export CVS_RSH=ssh
	export CVSUMASK=002
	export CVS_USER=$USER
fi

# Let's get an ssh agent ready
#if [ -z "$SSH_AGENT_PID" ]; then
#  eval $(ssh-agent) > /dev/null 2>&1
#fi

# unset anything internal so we don't confuse other programs later
unset -f exists

[[ "$UNAME" =~ CYGWIN ]] && cd ~ # hack for mintty

# Enable bash-completion on a plethora of systems
if [[ "$UNAME" =~ BSD ]] && [ -f /usr/local/etc/bash_completion ]; then
  unset UNAME
  . /usr/local/etc/bash_completion
elif [[ "$UNAME" =~ Darwin ]] && [ -f /opt/local/etc/bash_completion ]; then
  unset UNAME
  . /opt/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
  unset UNAME
  . /etc/bash_completion
else
  unset UNAME
fi
