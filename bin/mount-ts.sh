#!/bin/sh
#
# NOTE: this script requires that the user have write permission to
# the /Volumes directory so it can create the mount point.
#
########################################################################

function usage
{
    echo "usage: mount-ts.sh [[-r] | [-w] | [--read-only] | [--read-write] | [-h]]"
}

### Main
readOnly=''
readWrite=''
success=''

# Get our command line arguments
while [ "$1" != '' ]
do
    case $1 in
        -r | --read-only )      shift
                                readOnly=1
                                ;;
        -w | --read-write )     shift
                                readWrite=1
                                ;;
        -h | --help )           usage
                                exit 0
                                ;;
        * )                     usage
                                exit 1
    esac
done

# Either read-only or read-write mode must be specified, but not both
if [[ ($readOnly && $readWrite) || (! $readOnly && ! $readWrite) ]]
then
   usage
   exit 1
fi

# Set the mounting option
readOnlyOption=''
if [[ $readOnly ]]
then
    readOnlyOption='-r '
fi

# Mount the drive
if mkdir -p /Volumes/share; then
    echo "Mounting..."
    if mount $readOnlyOption -t smbfs -o nodev,nosuid smb://terryn:@hs-dhtgl5f5/share /Volumes/share; then
        success=1
    fi
fi

if [[ $success ]]
then       
    echo "Mounted."
    exit 0
else
    echo "NOT mounted."
    exit 1
fi

# End of file
