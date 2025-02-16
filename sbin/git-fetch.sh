#!/bin/sh
#============================================================================
# Simple script to fetch Git commits from remote for all Replenium projects.
#============================================================================

repoHome="/c/Users/Terry.AzureAD/Source/Repos"

cd "$repoHome"

for dir in *
do 
  if [ -d "$dir" ]; then
    cd "$dir"
    echo -e "\n===> $PWD <===\n"
    git fetch
    cd ..
  fi
done 
