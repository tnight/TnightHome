alias ls='ls -FG'
alias pasftp='ftp 9723.pilchuckaudubon@216.211.129.207'
alias v=vdir
alias va='v -a'
alias vdir='ls -l'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

