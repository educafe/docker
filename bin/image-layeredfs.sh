#!/bin/bash
if [ -z $1 ]; then
	while read imageid
	do
		docker inspect -f '{{.RepoTags}}' $imageid
		while read upperdir 
		do
			while read image 
			do
				if [ -f /var/lib/docker/overlay2/$image/lower ]; then
					# docker image ls | grep $imageid | awk '{print $1 ":" $2}'
					echo " UpperDir=$image"
					IFS=:
					for var in $(cat /var/lib/docker/overlay2/$image/lower)
					do
						readlink /var/lib/docker/overlay2/$var | cut -d '/' -f2 | sed 's/^/ /'
					done
				else
					docker image ls | grep $imageid | awk '{print $1 ":" $2}'
					echo " UpperDir=$image"
				fi
			done < <(cut -d '/' -f6 < <(echo $upperdir))
		done < <(grep "UpperDir" < <(docker image inspect $imageid))
		echo
	done < <(docker image ls -q)
else
	for imagename in $@
	do
		docker inspect -f '{{.RepoTags}}' $imagename
		while read upperdir 
		do
			while read image 
			do
				if [ -f /var/lib/docker/overlay2/$image/lower ]; then
					# docker image ls | grep $imageid | awk '{print $1 ":" $2}'
					echo " UpperDir=$image"
					IFS=:
					for var in $(cat /var/lib/docker/overlay2/$image/lower)
					do
						readlink /var/lib/docker/overlay2/$var | cut -d '/' -f2 | sed 's/^/ /'
					done
				else
					docker image ls | grep $image | awk '{print $1 ":" $2}'
					echo " UpperDir=$image"
				fi
			done < <(cut -d '/' -f6 < <(echo $upperdir))
		done < <(grep "UpperDir" < <(docker image inspect $imagename))
		echo
	done
fi


