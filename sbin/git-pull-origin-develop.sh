#!/bin/sh
#============================================================================
# Simple script to pull and merge the latest changes for all Replenium
# projects. We ignore the local branch's configuration of which remote
# branch to track and always pull from the remote branch "develop"
# because that is where changes from other developers will appear.
# ============================================================================

repoHome="/c/Users/Terry.AzureAD/Source/Repos"

cd "$repoHome"

for dir in *
do 
  if [ -d "$dir" ]; then
    cd "$dir"
    echo -e "\n===> $PWD <===\n"
    git pull origin develop
    cd ..
  fi
done 
