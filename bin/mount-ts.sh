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
    read -r -d '' usage <<- 'EOF'
	usage: mount-ts.sh [[-h] | [-r] | [-w] | [-u] | [-n] | [--read-only] | [--read-write] | [--unmount] | [--dry-run] | [--help]]
        {-f|--force}: Force the unmounting of the file share
	{-h|--help}: Print this usage message
	{-n|--dry-run}: Just print the comamnds we would have run; do not run them
	{-r|--read-only}: Mount the file share in read-only mode
	{-u|--unmount}: Unmount the file share instead of mounting it
	{-w|--read-write}: Mount the file share in read-write mode

	NOTE: exactly one of {-r|--read-only}, {-w|--read-write}, or {-u|--unmount} must be specified.
EOF
    echo "$usage"
}

### Main
forcedOption=''
isDryRun=''
isForced=''
isReadOnly=''
isReadWrite=''
isMountMode=1
linkTo='/Volumes/share'
mountPoint="${HOME}/Volumes/share"
readOnlyOption=''
remoteHost='192.168.0.100'
username='terryn'

# Get our command line arguments
while [ "$1" != '' ]; do
    case $1 in
	-f | --force )          shift
				isForced=1
				;;
        -h | --help )           usage
                                exit 0
                                ;;
        -n | --dry-run )        shift
                                isDryRun=1
                                ;;
        -r | --read-only )      shift
                                isReadOnly=1
                                ;;
        -u | --unmount )        shift
                                isMountMode=''
                                ;;
        -w | --read-write )     shift
                                isReadWrite=1
                                ;;
        * )                     usage
                                exit 1
    esac
done

# We must be in one and only one of these modes: "mount read-only," "mount read-write," or "unmount."
if [[ ! ( (! $isReadOnly && ! $isReadWrite && ! $isMountMode) || (! $isReadOnly && $isReadWrite && $isMountMode) || ($isReadOnly && ! $isReadWrite && $isMountMode) ) ]]; then
   usage
   exit 1
fi

# Set the mounting option if we are in forced mode.
if [[ $isForced ]]; then
    forcedOption='-f '
fi

# Set the mounting option if we are in read-only mounting mode.
if [[ $isReadOnly ]]; then
    readOnlyOption='-r '
fi

if [[ $isMountMode ]]; then
    # Make sure the mount point exists
    if [[ -d "$mountPoint" ]]; then
	echo "Found mount point [$mountPoint]; skipping mkdir command."
    else
	mkdirCmd="mkdir -p $mountPoint"
	if [[ $isDryRun ]]; then
	    cmd="echo \"Would have run: [$mkdirCmd]\""
	else
	    cmd="$mkdirCmd"
	fi

	if eval "$cmd"; then
	    echo "Made directory for mount point."
	else
	    echo "Failed to make directory for mount point."
	    exit 1
	fi
    fi

    # Mount the drive
    echo "Mounting..."
    mountCmd="mount $readOnlyOption -t smbfs -o nodev,nosuid smb://${username}:@${remoteHost}/share $mountPoint"
    if [[ $isDryRun ]]; then
	cmd="echo \"Would have run: [$mountCmd]\""
    else
	cmd="$mountCmd"
    fi
    if eval "$cmd"; then
	echo "Mounted."
    else
	echo "NOT mounted."
	exit 1
    fi
else
    # Unmount the drive
    echo "Unmounting..."
    unmountCmd="umount $forcedOption $mountPoint"
    if [[ $isDryRun ]]; then
	cmd="echo \"Would have run: [$unmountCmd]\""
    else
	cmd="$unmountCmd"
    fi
    if eval "$cmd"; then
	echo "Unmounted."
    else
	echo "NOT unmounted."
	exit 1
    fi
fi

# Check for whether the link already exists; if so, don't create it. Likewise when unlinking, if the link does not exist, don't bother trying to unlink.
isLinkCmdNeeded=''
if [[ $isMountMode ]]; then
    if [[ ! -d "$linkTo" ]]; then
	isLinkCmdNeeded=1
	lnCmd="sudo ln -s \"$mountPoint\" \"$linkTo\""
    fi
else
    if [[ -d "$linkTo" ]]; then
	isLinkCmdNeeded=1
	lnCmd="sudo rm \"$linkTo\""
    fi
fi

if [[ ! $isLinkCmdNeeded ]]; then
    echo "Skipping unnecessary link-related command."
else
    if [[ $isDryRun ]]; then
	cmd="echo \"Would have run: [$lnCmd]\""
    else
	cmd="$lnCmd"
    fi

    if eval "$cmd"; then
	if [[ $isMountMode ]]; then
	    echo "Linked."
	else
	    echo "Unlinked."
	fi
	exit 0
    else
	if [[ $isMountMode ]]; then
	    echo "NOT linked."
	else
	    echo "NOT unlinked."
	    exit 1
	fi
    fi
fi

# End of file
