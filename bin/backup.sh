#!/bin/sh
echo BEGIN `date` >> ~/tmp/backup.log
# 
# Sample from website
### /usr/bin/caffeinate -s /usr/bin/rsync -aH /Users user@rsync.net: >> ~/tmp/backup.log
# 
# Dry run mode
/usr/bin/rsync --exclude=.DS_Store -Habcnv /Users/tnight/Cloud\ Drive/ //Volumes/share/terryn/My\ Documents/Local\ \(NOT\ Cloud\)\ Drive >> ~/tmp/backup.log
# 
# The real deal
### /usr/bin/rsync --exclude=.DS_Store -Habcv /Users/tnight/Cloud\ Drive/ //Volumes/share/terryn/My\ Documents/Local\ \(NOT\ Cloud\)\ Drive >> ~/tmp/backup.log
echo END `date` >> ~/tmp/backup.log

# End of file
