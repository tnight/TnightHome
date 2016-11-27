#!/bin/sh
#
# NOTE: Due to the new permissions attached to /Volumes in MacOS X
# Sierra, this script now mounts the file share within the running
# user's home directory and points to the file share via a symbolic
# link in /Volumes.
#
########################################################################

function usage
{
    echo "usage: mount-ts.sh [[-r] | [-w] | [-n] | [--read-only] | [--read-write] | [--dry-run] | [-h]]"
}

### Main
dryRun=''
linkTo='/Volumes/share'
mountPoint="${HOME}/Volumes/share"
readOnly=''
readWrite=''
remoteHost='192.168.0.10'
success=''
username='terryn'

# Get our command line arguments
while [ "$1" != '' ]; do
    case $1 in
        -r | --read-only )      shift
                                readOnly=1
                                ;;
        -w | --read-write )     shift
                                readWrite=1
                                ;;
        -n | --dry-run )        shift
                                dryRun=1
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
if [[ $readOnly ]]; then
    readOnlyOption='-r '
fi

# Make sure the mount point exists
mkdirCmd="mkdir -p $mountPoint"
if [[ $dryRun ]]; then
    cmd="echo \"Would have run: [$mkdirCmd]\""
else
    cmd="$mkdirCmd"
fi

if eval "$cmd"; then
    echo "Made directory for mount point."

    # Mount the drive
    echo "Mounting..."
    mountCmd="mount $readOnlyOption -t smbfs -o nodev,nosuid smb://${username}:@${remoteHost}/share $mountPoint"
    if [[ $dryRun ]]; then
	cmd="echo \"Would have run: [$mountCmd]\""
    else
	cmd="$mountCmd"
    fi
    if eval "$cmd"; then
	success=1
    fi
else
    echo "Make directory command FAILED: [$cmd]."
fi

if [[ $success ]]
then       
    echo "Mounted."
else
    echo "NOT mounted."
fi

if [[ $success ]]; then
    lnCmd="sudo ln -s \"$mountPoint\" \"$linkTo\""
    if [[ $dryRun ]]; then
	cmd="echo \"Would have run: [$lnCmd]\""
    else
	cmd="$lnCmd"
    fi
    if eval "$cmd"; then
	success=1
    else
	success=''
    fi
fi

if [[ $success ]]
then
    echo "Linked."
    exit 0
else
    echo "NOT linked."
    exit 1
fi

# End of file
