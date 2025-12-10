# Pull in our aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Make sure we can find our home directory.
export HOME=~

# Set up some attractive and readable colors for the LS command.
LSCOLORS=gxfxcxdxbxegedabagacad
export LSCOLORS

# Set up our path the way we want it.
PATH="$HOME/bin:$HOME/sbin:/opt/homebrew/bin:$PATH"

#
# Git Prompt
#

if command -v brew &> /dev/null; then
    # Mac OS X with Brew
    if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
        . $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
    fi
elif [ -f /etc/git-prompt.sh ]; then
    # Generic Unix
    . /etc/git-prompt.sh
elif [ -f /mingw64/share/git/completion/git-prompt.sh ]; then
    # Windows with Git Bash
    . /mingw64/share/git/completion/git-prompt.sh
elif [ -f ~/.git-prompt.sh ]; then
    # Local to the User
    . ~/.git-prompt.sh
fi

#
# Git Completion
#

if command -v brew &> /dev/null; then
    # Mac OS X with Brew
    if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
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

# Set up our shell prompt
if [ -z "$MSYSTEM" ]; then
    export MSYSTEM=`uname -m`
fi

export PS1='\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\][\w]\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '

# Detect when we are running inside Emacs and make a few changes.
if [ -n "$INSIDE_EMACS" ]; then
    echo "We are inside Emacs!"

    # Rather than paginate, output flows into the Emacs shell buffer.
    export GIT_PAGER="cat"

    # Give our shell window a reasonable value that Emacs can handle.
    export TERM=ansi
fi

# End of file
