#! /bin/bash

# Less enhancements
export PAGER=less
export LESS="-iMSx4 -FXR"
export LESSOPEN='|~/.lessfilter %s'

# Bash profile
alias ep="vim ~/.bash_stuff"
alias rp=". /home/nick/.bash_profile"
function lp {
  echo 'Getting .bash_profile...'
  curl -o ~/.bash_profile -L https://github.com/nickgronow/dotfiles/blob/master/scripts/remote/bash-profile.sh
  echo 'Getting .psqlrc...'
  curl -o ~/.psqlrc -L https://github.com/nickgronow/dotfiles/blob/master/scripts/remote/psqlrc
  echo 'Getting .vimrc...'
  curl -o ~/.vimrc -L https://github.com/nickgronow/dotfiles/blob/master/scripts/remote/vimrc
  echo 'Getting .lessfilter...'
  curl -o ~/.lessfilter -L https://github.com/nickgronow/dotfiles/blob/master/scripts/remote/lessfilter
  echo 'Setting vi editing mode...'
  echo "set editing-mode vi" > ~/.inputrc
}
function lb {
  curl -o ~/.bash_profile -L https://github.com/nickgronow/dotfiles/blob/master/scripts/remote/bash-profile.sh
}

# LS
alias ls="ls --color=auto"
alias lsa="ls -alh"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Allow less to open zipped files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Start script
if [ -e ".bash_stuff" ]
then
  . .bash_stuff
fi

# Rails
alias bx='bundle exec'
alias rs='bundle exec rails'
alias rk='bundle exec rake'
