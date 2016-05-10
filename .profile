alias ls='ls -FG'
alias lsa='ls -A'
alias lst='ls -t'
alias r='fc -e -'
alias pasftp='ftp 9723.pilchuckaudubon@216.211.129.207'
alias v=vdir
alias va='v -A'
alias vdir='ls -l'
alias vt='v -t'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

PATH="$HOME/bin:$PATH"

GIT_OAUTH_TOKEN="495d1860d90421bc553b615e356652506917b3be"
export GIT_OAUTH_TOKEN

# End of file
