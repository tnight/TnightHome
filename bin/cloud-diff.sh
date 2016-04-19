#!/bin/sh

cd ~/Cloud\ Drive
/bin/ls -R > ~/tmp/Cloud-Drive.txt
cd ~/Documents/Local\ \(NOT\ Cloud\)\ Drive
/bin/ls -R > ~/tmp/Local-NOT-Cloud-Drive.txt
diff -u ~/tmp/Local-NOT-Cloud-Drive.txt ~/tmp/Cloud-Drive.txt | tee ~/tmp/Cloud-Drive-Diff.txt

# End of file
