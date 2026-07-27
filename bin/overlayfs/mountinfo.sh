#!/bin/sh
if [ $# -lt 1 ]; then
	echo "Usage : $(basename $0) <container name or id>"
	exit
fi

PID=$(docker container inspect --format '{{.State.Pid}}' "$1") || exit 1

if [ "$PID" -eq 0 ]; then
    echo "Container is not running."
    exit 1
fi

info=$(sudo grep 'overlay' "/proc/$PID/mountinfo")
echo $info|sed 's/,/\n/g'|grep lowerdir|sed 's/=/\n /g'|sed 's/:/\n /g'
echo
echo $info|sed 's/,/\n/g'|grep upperdir|sed 's/=/\n /g'
echo
echo $info|sed 's/,/\n/g'|grep workdir|sed 's/=/\n /g'
echo