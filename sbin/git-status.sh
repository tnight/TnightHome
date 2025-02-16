#!/bin/sh
#============================================================================
# Simple script to show current Git status for all Replenium projects.
#============================================================================

repoHome="/c/Users/Terry.AzureAD/Source/Repos"

cd "$repoHome"

for dir in *
do 
  if [ -d "$dir" ]; then
    cd "$dir"
    echo -e "\n===> $PWD <===\n"
    git status
    cd ..
  fi
done 
