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
			images[$index]=$(basename $dir)
		fi
	fi
done

IFS=:
for image in ${images[@]}
do
	tput setaf 4
	echo ${image}
	tput setaf 0
	echo $(cat ${image}/lower)
	echo
done


