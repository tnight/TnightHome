#!/bin/sh

baseCmd='ffmpeg'
jpgFile='file.jpg'
mp3File=''

function usage
{
    read -r -d '' usage <<- 'EOF'
	usage: mp3ToJpg.sh mp3FileName [jpgFileName]

	NOTE: if jpgFileName is not given, the file name file.jpg will be used.
EOF
    echo "$usage"
}

# Check that we have the required number of command line arguments.
if [ "$#" -lt 1 ]; then
    usage
    exit 1
fi

# Get our command line argument(s).
mp3File="$1"
if [ "$#" -gt 1 ]; then
    jpgFile="$2"
fi

$baseCmd -i "${mp3File}" -an -c:v copy -y "${jpgFile}"

# End of file
