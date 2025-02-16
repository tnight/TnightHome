#!/bin/sh
#============================================================================
# Simple script to pull and merge the latest changes for all Replenium
# projects.
#
# NOTE: The script also changes your current branch to 'develop' so if
# you want to continue working on a private branch, you'll need to
# switch back to it after the script runs.
#
# TODO: Enhance the script so that it preserves the current working
# branch while still updating the develop branch.
#
#============================================================================

repoHome="/c/Users/Terry.AzureAD/Source/Repos"

cd "$repoHome"

for dir in *
do 
  cd "$dir"
  echo -e "\n===> $PWD <===\n"
  if git checkout develop; then
      git pull
  fi
  cd ..
done 
