# ~/.bashrc: executed by bash(1) for non-login shells.

PATH=$HOME:/usr/sbin:/usr/share/sbin:$PATH

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
TERM=xterm-256color
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
source ~/.git-prompt.sh
memfree() {
	awk '/MemFree/ { printf "%.3f \n",$2/1024 }' /proc/meminfo
}
datasrc() {
	echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]
}
curproc() {
	eval ls -1 | wc -l
}
srvuptime() {
	uptime | tr ":" "h" | tr "," "m" | tr "h" ":" | cut -c14,16,21-26
}
PS1="\[\033[00m\]\n${debian_chroot:+($debian_chroot)}\[\033[01;33m\] ※ \[\033[00;34m\] \A\[\033[00m\]\[\033[00;33m\] ≈\[\033[00m\]\[\033[00;34m\] $(memfree)mb\[\033[00m\]\[\033[00;33m\] ≈\[\033[00m\]\[\033[00;34m\] prc($(curproc))\[\033[00m\]\[\033[00;33m\] ≈\[\033[00;34m\] $(srvuptime)\n\[\033[00m\]\[\033[01;33m\] | \[\033[00m\]\[\033[00;33m\] ≈\[\033[00m\]\[\033[00;37m\]$(__git_ps1 " (%s)")\n\[\033[00m\]\[\033[01;33m\] Ŀ—√\[\033[00m\]\[\033[01;37m\] \u\[\033[00m\]\[\033[01;36m\]:\[\033[00m\]\[\033[00;33m\] ≈\[\033[00m\]\[\033[00;37m\]\H\[\033[00m\]\[\033[00;33m\] ≈\[\033[00m\]\[\033[01;36m\] \w\[\033[00m\]\[\033[00;37m\] ≈\[\033[00m\]\[\033[01;37m\] ‡\[\033[00m\] "

unset color_prompt force_color_prompt

# This xterm titled as user@host:dir

#  enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# BEGIN IMAGE METADATA SETTINGS
export OS_ARCH=aarch64
export OS_FLAVOUR=OpenWrt-Snapshot
export OS_NAME=Linux/GNU
export APP_NAME=OpenWrt
export IMAGE_VERSION=SNAPSHOT
export APP_VERSION=22.03
# END IMAGE METADATA SETTINGS

# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
