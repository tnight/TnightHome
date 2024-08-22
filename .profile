alias blmm='mv -v /Volumes/music/b*.txt /Volumes/music/zzBackUpLogArchive'
alias bltm='tail /Volumes/music/b*.txt'
alias blvm='v /Volumes/music/b*.txt'
alias blms='mv -v /Volumes/share/b*.txt /Volumes/share/zzBackUpLogArchive'
alias blts='tail /Volumes/share/b*.txt'
alias blvs='v /Volumes/share/b*.txt'
alias del='rm -i'
alias dir=ls
alias gb='git branch'
alias gba='git branch -a'
alias gcm='git checkout main'
alias gdcw='git diff --color -w'
alias gs='git status'
alias gsl='git stash list'
alias ls='ls -FG --color'
alias lsa='ls -A'
alias lsd='ls -d'
alias lsr='ls -R'
alias lst='ls -t'
alias m2j='mp3ToJpg.sh'
alias mtro='mount-ts.sh --read-only'
alias mtrw='mount-ts.sh --read-write'
alias r='fc -e -'
alias umt='mount-ts.sh --unmount'
alias umtf='mount-ts.sh --force --unmount'
alias v=vdir
alias va='v -A'
alias vd='v -d'
alias vdir='ls -l'
alias vh='v -h'
alias vr='v -R'
alias vt='v -t'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

GIT_OAUTH_TOKEN="495d1860d90421bc553b615e356652506917b3be"
export GIT_OAUTH_TOKEN

export HOME=~

LSCOLORS=gxfxcxdxbxegedabagacad
export LSCOLORS

PATH="$HOME/bin:$PATH"

# Handy GIT-oriented shell prompt
source /usr/local/bin/git-prompt.sh
PS1='[\h:\W \u$(__git_ps1 " (%s)")]\$ '

# Needed for perlbrew
source ~/perl5/perlbrew/etc/bashrc

# Keep suggestd process from consuming CPU
pkill -STOP suggestd

# Change to our home directory
cd $HOME

# End of file
