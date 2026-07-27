#!/bin/bash
if [ $(id -u) -eq 0 ]; then
	DOCKERHOME=/var/lib/docker
else
	DOCKERHOME=$HOME/.local/share/docker
	fi
	
if [ -z $1 ]; then
	while read imageid
	do
		docker inspect -f '{{.RepoTags}}' $imageid
		# docker image inspect -f ' {{range .RootFS.Layers}}{{ println .}} {{end}}' $imageid
		notrunc_imageid=$(docker image inspect -f '{{.Id}}' $imageid)
		notrunc_imageid=${notrunc_imageid#sha256:}
		diffids=$(jq -r '.rootfs.diff_ids[]' "$DOCKERHOME/image/overlay2/imagedb/content/sha256/$notrunc_imageid")
		for diffid in $diffids
		do
			echo " ${diffid#sha256:}"
		done
	done < <(docker image ls -q)
else
	for imageid in $@
	do
		docker inspect -f '{{.RepoTags}}' $imageid
		# docker image inspect -f ' {{range .RootFS.Layers}}{{ println .}} {{end}}' $image
		notrunc_imageid=$(docker image inspect -f '{{.Id}}' $imageid)
		notrunc_imageid=${notrunc_imageid#sha256:}
		diffids=$(jq -r '.rootfs.diff_ids[]' "$DOCKERHOME/image/overlay2/imagedb/content/sha256/$notrunc_imageid")
		for diffid in $diffids
		do
			echo " ${diffid#sha256:}"
		done
	done
fi