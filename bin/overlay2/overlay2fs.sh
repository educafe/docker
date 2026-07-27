#!/bin/bash
if [ $(id -u) -eq 0 ]; then
	DOCKERHOME=/var/lib/docker
	FIELD='f6'
else
	DOCKERHOME=$HOME/.local/share/docker
	FIELD='f8'
fi

if [ -z $1 ]; then
	while read imageid
	do
		while read upperdir 
		do
			while read imagelayer
			do
				if [ -f $DOCKERHOME/overlay2/$imagelayer/lower ]; then
					docker inspect -f '{{.RepoTags}}' $imageid
					echo " UpperDir=$imagelayer"
					IFS=:
					for var in $(cat $DOCKERHOME/overlay2/$imagelayer/lower)
					do
						echo " LowerDir=$(readlink $DOCKERHOME/overlay2/$var | cut -d '/' -f2 | sed 's/^//')"
					done
				else
					docker inspect -f '{{.RepoTags}}' $imageid
					echo " UpperDir=$imagelayer"
				fi
			done < <(cut -d '/' -$FIELD < <(echo $upperdir))
		done < <(grep "UpperDir" < <(docker image inspect $imageid))
	done < <(docker image ls -q)
else
	for imagename in $@
	do
		docker inspect -f '{{.RepoTags}}' $imagename
		while read upperdir 
		do
			while read imagelayer 
			do
				if [ -f $DOCKERHOME/overlay2/$imagelayer/lower ]; then
					echo " UpperDir=$imagelayer"
					IFS=:
					for var in $(cat $DOCKERHOME/overlay2/$imagelayer/lower)
					do
						echo " LowerDir=$(readlink $DOCKERHOME/overlay2/$var | cut -d '/' -f2 | sed 's/^//')"
					done
				else
					echo " UpperDir=$imagelayer"
				fi
			done < <(cut -d '/' -$FIELD < <(echo $upperdir))
		done < <(grep "UpperDir" < <(docker image inspect $imagename))
	done
	# printf '\033[1A\033[2K'
fi


