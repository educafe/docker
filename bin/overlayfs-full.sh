#!/bin/bash
while read imageid
do
	while read upperdir 
	do
		while read image 
		do
			if [ -f /var/lib/docker/overlay2/$image/lower ]; then
				tput setaf 4
				docker image ls | grep $imageid | awk '{print $1}'
				echo UpperDir=$image
				tput setaf 0
				echo LowerDir=
				IFS=:
				for var in $(cat /var/lib/docker/overlay2/$image/lower)
				do
					readlink $var | cut -d '/' -f2
				done
			else
				tput setaf 4
				echo UpperDir=$image
				tput setaf 0
			fi
		done < <(cut -d '/' -f6 < <(echo $upperdir))
	done < <(grep "UpperDir" < <(docker image inspect $imageid))
	echo
done < <(docker image ls -q)

