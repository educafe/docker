#!/bin/bash

read dirs < <(echo /var/lib/docker/overlay2/*)
for dir in $dirs
do
	if [[ $(basename $dir) != 'l' ]]; then
		if [ ! -f $dir/lower ]; then
		echo
			tput setaf 5
			echo $(basename $dir) >&2
			tput setaf 0
			echo
		fi
	fi
done

for dir in $dirs
do
	if [[ $(basename $dir) != 'l' ]]; then
		if [ -f $dir/lower ]; then
			index=$(echo $(cat $dir/lower) | awk -F: '{printf NF}')
			# images[$index]=$(basename $dir)
			images[$index]=$dir
		fi
	fi
done

IFS=:
for image in ${images[@]}
do
	tput setaf 4
	echo $(basename ${image})
	tput setaf 0
	# echo $(cat ${image}/lower)
	for var in $(cat ${image}/lower)
	do
		echo -n "$var -> "
		readlink /var/lib/docker/overlay2/$var | cut -d'/' -f2
	done
	echo
done


