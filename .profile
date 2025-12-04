alias blmm='mv -v /Volumes/music/b*.txt /Volumes/music/zzBackUpLogArchive'
alias bltm='tail /Volumes/music/b*.txt'
alias blvm='v /Volumes/music/b*.txt'
alias blms='mv -v /Volumes/share/b*.txt /Volumes/share/zzBackUpLogArchive'
alias blts='tail /Volumes/share/b*.txt'
alias blvs='v /Volumes/share/b*.txt'
alias del='rm -i'
alias dir=ls
alias gb='git branch --color'
alias gba='gb -a'
alias gbaa='~/bin/git-branch.sh'
alias gbaaa='~/bin/git-branch-all.sh'
alias gbm='gb --merged'
alias gcd='git checkout develop'
alias gcm='git checkout main'
alias gdcw='git diff --color -w'
alias gds='git diff --stat'
alias gds132='git diff --stat=132 -w'
alias gf='git fetch'
alias gfa='~/bin/git-fetch.sh'
alias gl5='git log -5'
alias gs='git status'
alias gs132='git show --stat=132'
alias gsa='~/bin/git-status.sh'
alias gscw='git show --color -w'
alias gsl='git stash list'
alias gsla='~/bin/git-stash-list.sh'
alias gss='git stash show'
alias gss132='git stash show --stat=132'
alias gsscpw='git stash show --color --patch -w'
alias ls='ls -CFG --color'
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

export HOME=~

LSCOLORS=gxfxcxdxbxegedabagacad
export LSCOLORS

PATH="$HOME/bin:$HOME/sbin:/opt/homebrew/bin:$PATH"

if command -v brew &> /dev/null; then
    # Mac OS X with Brew
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
elif [ -f /etc/git-completion.bash ]; then
    # Generic Unix
    . /etc/git-completion.bash
elif [ -f /mingw64/share/git/completion/git-completion.bash ]; then
    # Windows with Git Bash
    . /mingw64/share/git/completion/git-completion.bash
elif [ -f ~/.git-completion.bash ]; then
    # Local to the User
    . ~/.git-completion.bash
fi

# Set up Perl to look for CPAN modules in our local library.
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# Keep suggestd process from consuming CPU
if command -v pkill &> /dev/null; then
    pkill -STOP suggestd
fi

# Change to our home directory
cd $HOME

# Detect when we are running inside Emacs and make a few changes.
if [ -n "$INSIDE_EMACS" ]; then
    echo "We are inside Emacs!"

    if [ -z "$MSYSTEM" ]; then
        export MSYSTEM=`uname -m`
    fi

    export PS1='\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\][\w]\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '
    export TERM=emacs
fi

# End of file
