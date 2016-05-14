#!/bin/sh

if mkdir /Volumes/share; then
    echo "Mounting..."
    mount -r -t smbfs -o nodev,nosuid smb://terryn:9bum9z3n@hs-dhtgl5f5/share /Volumes/share
    echo "Mounted."
else
    echo "NOT mounted."
fi

# End of file
