#!/bin/bash

read dirs < <(echo /var/lib/docker/overlay2/*)
for dir in $dirs
do
	if [[ $dir =~ "-init" ]]; then
		merged=$(basename $dir)
		merged=${merged%?????}
		echo $merged
		IFS=:
		for var in $(cat /var/lib/docker/overlay2/$merged/lower)
		do
			readlink "/var/lib/docker/overlay2/$var" | cut -d '/' -f2
		done
		echo
	fi
done



