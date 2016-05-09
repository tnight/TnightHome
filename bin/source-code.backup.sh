#!/bin/sh
#
########################################################################

# Where we will write our log of operations 
backupLog="~/logs/source-code.backup.log"

# Log our start time
echo BEGIN `date` >> $backupLog

# Save the date so we can use it to create our output directory
backupDate=$(date "+%Y-%m-%d")

# Define our source and target directories
backupSourcePath="~/proj"
backupTargetPath="/Volumes/share/terryn/proj-backup/${backupDate}"

# Make the output directory if it doesn't already exist 
mkdir -p "$backupTargetPath"

# Sample from website
### /usr/bin/caffeinate -s /usr/bin/rsync -aH /Users user@rsync.net: >> ~/tmp/backup.log

# Dry run mode
/usr/bin/caffeinate -s /usr/bin/rsync --exclude=.DS_Store -Habcnv "$backupSourcePath" "$backupTargetPath" >> "$backupLog"

# The Real Deal (same as dry run mode but without -n)
### /usr/bin/caffeinate -s /usr/bin/rsync --exclude=.DS_Store -Habcnv "$backupSourcePath" "$backupTargetPath" >> "$backupLog"

# Log our end time
echo END `date` >> "$backupLog"

# End of file
