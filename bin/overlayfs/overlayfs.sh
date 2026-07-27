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

options=$(sudo nsenter -t "$PID" -m -p -- findmnt -T / -n -o OPTIONS
) || exit 1

upper=$(
    printf '%s\n' "$options" | sed -n 's/.*upperdir=\([^,]*\).*/\1/p'
)

lower=$(
    printf '%s\n' "$options" | sed -n 's/.*lowerdir=\([^,]*\).*/\1/p'
)

echo "Docker container:"
echo " $(docker inspect --format '{{.Id}}' "$1")"

echo
echo "Writable container snapshot:"
echo " $upper"

echo
echo "Read-only image snapshots:"
printf '%s\n' "$lower" | tr ':' '\n' | sed 's/^/ /'
