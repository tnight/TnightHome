#!/bin/sh
#============================================================================
# Simple script to show current Git branches for all Replenium projects.
#============================================================================

repoHome="/c/Users/Terry.AzureAD/Source/Repos"

cd "$repoHome"

for dir in *
do 
  cd "$dir"
  echo -e "\n===> $PWD <===\n"
  git branch -a
  cd ..
done 
