#!/bin/bash

# Determine whether we're running under the Cygwin environment.
running_under_cygwin_env=$(uname -a | grep -i cygwin)

# Commands we'll need.  The get command tells curl to auto-resume, to
# take the remote file's modification time, and to impose a lowest
# speed limit of 300 bytes per second.
chmodCmd="/usr/bin/chmod"
chownCmd="/usr/bin/chown"
getCmd="/usr/bin/curl --remote-time --speed-limit 300 -C - --output"
rmCmd="/usr/bin/rm -f"
tarCmd="/bin/tar"
touchCmd="/usr/bin/touch"

# URL's and directories.
installPrefix="/usr/local"
installSuffix="mozilla"
mozUrl="ftp://ftp.mozilla.org/pub/mozilla/nightly/latest/mozilla-win32-installer-sea.exe"
recvDir="/usr/local/recv/browser/MozillaNightlies/$(date +%Y-%m-%d)"
recvFile="$recvDir/$(basename $mozUrl)"

# Make our receiving directory if it doesn't already exist.
if [ ! -d "$recvDir" ]
then
  mkdir "$recvDir"
fi

# Append the output filename to our get command.
getCmd="$getCmd $recvFile"

declare -i i
declare -i isDownloaded
isDownloaded=0
for (( i=1; i <= 10; i++ ))
do
  # Download the build.
  echo "Try $i: Getting nightly build and saving to [$recvFile]..."
  echo "Command = [$getCmd $mozUrl]"
  $getCmd $mozUrl
  if [ $? = 0 ]
  then
    echo "Successfully downloaded the build."
    isDownloaded=1
    break
  else
    echo "Download of the build failed."
  fi
  echo
done

# Bail out if we could not successfully download the build
if [ $isDownloaded = 0 ]
then
  echo "The build could not be downloaded, exiting."
  exit 1
fi

# Install the build.
#
# TRN: In the Cygwin environment, we don't actually "install" the build;
# we simply chmod it so it can be run.  The non-installer build is not
# used because, unlike on Linux, the Windows zipfile obviously installs
# a subset of what the Windows installer installs, and I don't want to
# deal with figuring out the all the differences and their implications
# right now.
#

if [ "$running_under_cygwin_env" ] 
then
  $chmodCmd a+x "$recvFile"
else
  cd $installPrefix
  $tarCmd -zxf "$recvFile"
  $chownCmd -R root.root "${installPrefix}/${installSuffix}"
fi

echo "Build installed."

exit 0

# End of script
