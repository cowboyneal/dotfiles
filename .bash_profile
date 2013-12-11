# ~/.bash_profile: executed by bash(1) for login shells.

umask 002

. ~/.bashrc

test -r /sw/bin/init.sh && . /sw/bin/init.sh

export PATH=/usr/local/git/bin:$PATH

export MANPATH=/usr/local/git/man:$MANPATH

##
# Your previous /Users/pater/.bash_profile file was backed up as /Users/pater/.bash_profile.macports-saved_2009-09-08_at_14:46:31
##

# MacPorts Installer addition on 2009-09-08_at_14:46:31: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

