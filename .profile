alias blt='tail /Volumes/share/b*'
alias blv='v /Volumes/share/b*'
alias dir=ls
alias ls='ls -FG'
alias lsa='ls -A'
alias lsd='ls -d'
alias lst='ls -t'
alias mtro='mount-ts.sh --read-only'
alias mtrw='mount-ts.sh --read-write'
alias r='fc -e -'
alias pasftp='ftp 9723.pilchuckaudubon@216.211.129.207'
alias v=vdir
alias va='v -A'
alias vd='v -d'
alias vdir='ls -l'
alias vt='v -t'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

GIT_OAUTH_TOKEN="495d1860d90421bc553b615e356652506917b3be"
export GIT_OAUTH_TOKEN

PATH="$HOME/bin:$PATH"

# Handy GIT-oriented shell prompt
source /usr/local/bin/git-prompt.sh
PS1='[\h:\W \u$(__git_ps1 " (%s)")]\$ '

# End of file
