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
PATH=~/bin                                  # script overrides for EoU
PATH=$PATH:~/.local/bin                     # Python installed packages
PATH=$PATH:/usr/local/bin:/usr/local/sbin   # local first for mit k5
PATH=$PATH:/bin:/usr/bin:/usr/games         # usual path
PATH=$PATH:/sbin:/usr/sbin                  # sudo/root stuff

MANPATH=/usr/share/man:/usr/local/share/man
[ -d /usr/pkg/man ] && MANPATH=$MANPATH:/usr/pkg/man
[ -d /usr/X11R7/man ] && MANPATH=$MANPATH:/usr/X11R7/man
[ -d /opt/man ] && MANPATH=$MANPATH:/opt/man
[ -d /opt/local/man ] && MANPATH=$MANPATH:/opt/local/man
export MANPATH

# Determine host type
UNAME=`uname`

case $UNAME in
    NetBSD* )
        PATH=$PATH:/usr/pkg/bin:/usr/pkg/sbin
        PATH=$PATH:/usr/X11R7/bin
        ;;
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
export LC_ALL='en_US.UTF-8'

# try to set DISPLAY smart
if [ -z "$DISPLAY" ] && [[ "$TERM" =~ xterm|rxvt ]] && [ -n "$SSH_CLIENT" ];
then
    export DISPLAY="`echo $SSH_CLIENT | awk '{ print $1 }'`:0.0"
fi

# Make BSD look like GNU
[[ "$UNAME" =~ FreeBSD|Darwin ]] && export LSCOLORS=ExGxFxdxCxDxDxhbadExEx

# Enable 256 color capabilities for appropriate terminals

# Set this variable in your local shell config if you want remote
# xterms connecting to this system, to be sent 256 colors.
# This can be done in /etc/csh.cshrc, or in an earlier profile.d script.
#   SEND_256_COLORS_TO_REMOTE=1

# Terminals with any of the following set, support 256 colors (and are local)
local256="$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION"

if [ -n "$local256" ] || [ -n "$SEND_256_COLORS_TO_REMOTE" ]; then
    case "$TERM" in
        xterm) TERM=xterm-256color;;
        screen) TERM=screen-256color;;
        rxvt) TERM=rxvt-256color;;
        Eterm) TERM=Eterm-256color;;
    esac
    export TERM
    
    if [ -n "$TERMCAP" ] && [ "$TERM" = "screen-256color" ]; then
        export TERMCAP=$(echo "$TERMCAP" | sed -e 's/Co#8/Co#256/g')
    fi
fi

unset local256

export COLORFGBG='lightgray;black'

# if exists git && [ -f ~/.git-prompt.sh ]; then
#     source ~/.git-prompt.sh
#     export GIT_PS1_SHOWDIRTYSTATE=true
#     export GIT_PS1_SHOWSTASHSTATE=true
#     export GIT_PS1_SHOWUPSTREAM="auto"
# fi

set_bash_prompt() {
    # prompt stuff
    local blue1="\033[1;34m"
    local blue2="\[$blue1\]"
    local default1="\033[0m"
    local default2="\[$default1\]"
    #local cyan_blue="\[\033[0;36;44m\]"
    local black_blue="\[\033[0;30;44m\]"
    local white_blue="\[\033[0;0;44m\]"

    PS1=" \! $black_blue$white_blue$PS1"

    if [[ "$TERM" =~ wsvt25 ]]; then
      PS1="$default2[$blue2\!$default2] $blue2\h $default2:$blue2 \w$default2 "
    fi

#    if [ -n "$GIT_PS1_SHOWDIRTYSTATE" ]; then
#        local git_info=$(__git_ps1 "%s")
#
#        if [ -n "$git_info" ]; then
#            if [[ "$git_info" =~ ^\(.+\) ]]; then
#                local tag=`echo "$git_info" | grep -oP '\(.*?\)'`
#                local new_tag=${tag#(}
#                new_tag=${new_tag%)}
#                git_info=${git_info/$tag/$new_tag}
#            fi
#
#            PS1="$PS1($blue2$git_info$default2) "
#        fi
#    fi
    
    case `/usr/bin/whoami` in
      root* ) PS1=$PS1'# ' ;;
      * ) PS1=$PS1"\$ " ;;
    esac
    
    PS1=$PS1$default2
    
    if [[ "$TERM" =~ xterm|rxvt|screen|tmux ]]; then
        PS1="\[\033]0;[ \u @ \h ] - "`tty | sed 's!/dev/!!'`" : \w\007\]$PS1"
    fi

    export PS1
}

export PS2
export PROMPT_DIRTRIM=3
export PROMPT_COMMAND=set_bash_prompt

if exists powerline-daemon && [[ ! "$TERM" =~ wsvt25 ]]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION="1"
    POWERLINE_BASH_SELECT="1"

    case $UNAME in
        Linux* )
            test -e /usr/share/powerline/bindings/bash/powerline.sh && \
                . /usr/share/powerline/bindings/bash/powerline.sh
            ;;
        FreeBSD* )
            test -e /usr/local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh && \
                . /usr/local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh
            ;;
        NetBSD* )
            test -e /usr/pkg/lib/python3.11/site-packages/powerline/bindings/bash/powerline.sh && \
                . /usr/pkg/lib/python3.11/site-packages/powerline/bindings/bash/powerline.sh
            ;;
    esac
fi

# Set aliases proper. Uncomment the following line to pull in more external
# aliases.
#test -e ~/.alias && . ~/.alias

alias 'reload'='source ~/.bashrc'

case $UNAME in
    FreeBSD | Darwin* ) lsopts='-GF' ;;
    Linux | CYGWIN* )   lsopts='--color=auto -F' ;;
    * )                 lsopts='-F' ;;
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
alias 'cdd'='cd "$OLDPWD"'
alias 'psme'="ps x | $PAGER"
alias 'pss'="ps aux | $PAGER"
alias 'grep'='grep --color=auto'
alias 'egrep'='egrep --color=auto'
alias 'fgrep'='fgrep --color=auto'
exists rsync && alias 'rsync'='rsync -avzhe ssh --progress'

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
exists alacritty && alias 'alasmitty'='alacritty -o "window.dimensions.lines=26"'

if [[ "$TERM" =~ screen ]]; then
    exists vim && alias 'vim'='vim -T xterm'
    exists w3m && alias 'w3m'='w3m -title=xterm'
fi

if [[ "$TERM" =~ screen-256color ]]; then
    exists vim && alias 'vim'='vim -T xterm-256color'
fi

# Portability vars
bsd1=
bsd2=

if [[ "$UNAME" =~ BSD|Darwin ]]; then
    bsd1=-
    bsd2="${bsd1}p "
fi

# Shell Functions, because copying tiny scripts sucks, amirite
slay() { # What we used on Solaris because killall killed all procs
    local p
    for p in `ps ${bsd1}axc -o pid= -o command= | awk /"$1"/'{print $1}'`; do
        kill $p
    done
}

got() { # got <process name>?
    local proc=${1%\?}
    local pids=$( ps ${bsd1}axc -o pid= -o command= | awk /"$proc"/'{print $1}' )
    if [ -n "$pids" ]; then
        ps w ${bsd2}$pids
    else
        echo "$proc not found"
    fi
}

c() {
    echo ${1} | bc -l
}

# IRC stuff
if exists epic || exists BitchX || exists bitchx || exists ircii; then
    export EMAIL=cowboyneal@gmail.com
    export IRCNICK=CowboyNeal
    export IRCSERVER=us.slashnet.org
    export IRCPORT=6667
fi

# mosh prefs
if exists mosh; then
    export MOSH_TITLE_NOPREFIX=1
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

[[ "$UNAME" =~ CYGWIN ]] && cd ~ # hack for mintty

# Enable bash-completion on a plethora of systems
if [[ "$UNAME" =~ FreeBSD ]] && [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
elif [[ "$UNAME" =~ NetBSD ]] && [ -f /usr/pkg/share/bash-completion/bash_completion ]; then
    . /usr/pkg/share/bash-completion/bash_completion
elif [[ "$UNAME" =~ Darwin ]] && [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

unset UNAME
