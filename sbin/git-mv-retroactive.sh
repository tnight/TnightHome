#!/bin/sh

oldFile="$1"
newFile="$2"

if [ -f "$1" ]; then
    echo "Old file $1 was found! Expected to be not found."
    exit 1
fi

if [ ! -f "$2" ]; then
    echo "New file $2 was not found! Expected to be found."
    exit 1
fi

mv "$newFile" ~/tmp/foo.cs
touch "$oldFile"
git mv -v "$oldFile" "$newFile"
mv ~/tmp/foo.cs "$newFile"

# End of file
