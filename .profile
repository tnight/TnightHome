alias blm='mv -v /Volumes/share/b*.txt /Volumes/share/zzBackUpLogArchive'
alias blt='tail /Volumes/share/b*.txt'
alias blv='v /Volumes/share/b*.txt'
alias dir=ls
alias gba='git branch -a'
alias ls='ls -FG'
alias lsa='ls -A'
alias lsd='ls -d'
alias lsr='ls -R'
alias lst='ls -t'
alias mtro='mount-ts.sh --read-only'
alias mtrw='mount-ts.sh --read-write'
alias r='fc -e -'
alias umt='mount-ts.sh --unmount'
alias v=vdir
alias va='v -A'
alias vd='v -d'
alias vdir='ls -l'
alias vr='v -R'
alias vt='v -t'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

GIT_OAUTH_TOKEN="495d1860d90421bc553b615e356652506917b3be"
export GIT_OAUTH_TOKEN

LSCOLORS=gxfxcxdxbxegedabagacad
export LSCOLORS

PATH="$HOME/bin:$PATH"

# Handy GIT-oriented shell prompt
source /usr/local/bin/git-prompt.sh
PS1='[\h:\W \u$(__git_ps1 " (%s)")]\$ '

# Needed for perlbrew
source ~/perl5/perlbrew/etc/bashrc

# End of file
