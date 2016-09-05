#!/bin/sh

if [ "$1" = "-v" ]
then
  verbose=1
else
  verbose=0
fi

if [ "$1" = "-h" ]
then
  echo "Usage: $0 [-h] [-v]"
  echo "-h: help"
  echo "-v: verbose"
  exit
fi

### host=foobar.blah
#
host=216.231.43.1

while true
do
  if ((ping $host > /dev/null))
  then
    if [ $verbose = "1" ]
    then
      echo "Ping result: success."
    fi
  else
    echo ""
    echo "Ping result: failure."
  fi
  sleep 30
done

