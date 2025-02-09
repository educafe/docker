#!/bin/bash
IMAGELAYERHOME=/var/lib/docker/image/overlay2/layerdb/sha256
if [ -z $1 ]; then
	while read imageid
	do
		docker inspect -f '{{.RepoTags}}' $imageid
		docker image inspect -f ' {{range .RootFS.Layers}}{{ println .}} {{end}}' $imageid
	done < <(docker image ls -q)
else
	for image in $@
	do
		docker inspect -f '{{.RepoTags}}' $image
		docker image inspect -f ' {{range .RootFS.Layers}}{{ println .}} {{end}}' $image
	done
fi