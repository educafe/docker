#!/bin/bash
if [ $(id -u) -eq 0 ]; then
	DOCKERHOME=/var/lib/docker
	FIELD='f6'
else
	DOCKERHOME=$HOME/.local/share/docker
	FIELD='f8'
fi

read dirs < <(echo $DOCKERHOME/docker/overlay2/*)
for dir in $dirs
do
	if [[ $dir =~ "-init" ]]; then
		merged=$(basename $dir)
		merged=${merged%?????}
		echo $merged
		IFS=:
		for var in $(cat $DOCKERHOME/docker/overlay2/$merged/lower)
		do
			readlink "$DOCKERHOME/docker/overlay2/$var" | cut -d '/' -f2
		done
		echo
	fi
done



