#!/bin/sh
#============================================================================
# Simple script to list current Git stashes for all Replenium projects.
#============================================================================

repoHome="/c/Users/Terry.AzureAD/Source/Repos"

cd "$repoHome"

for dir in *
do 
  cd "$dir"
  echo -e "\n===> $PWD <===\n"
  git stash list
  cd ..
done 
