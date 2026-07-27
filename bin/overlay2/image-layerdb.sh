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
		imageid=${imageid#sha256:}
		imageName=$(docker image inspect $imageid -f '{{.RepoTags}}')
		echo "$imageName"
		diffids=$(jq -r '.rootfs.diff_ids[]' "$DOCKERHOME/image/overlay2/imagedb/content/sha256/$imageid") 
		for diffid in $diffids
		do
			diffid=${diffid#sha256:}
			for layerdb_id in $DOCKERHOME/image/overlay2/layerdb/sha256/*
			do
				diff_val=$(cat $layerdb_id/diff)
				diff_val=${diff_val#sha256:}
				if [ $diff_val = $diffid ]; then
					echo " $(basename $layerdb_id)"
				fi
			done
		done
	done < <(ls $DOCKERHOME/image/overlay2/imagedb/content/sha256)
else
	for short_imageid in "$@"
	do
		imageid=$(docker image inspect $short_imageid -f '{{.Id}}')
		imageid=${imageid#sha256:}
		imageName=$(docker image inspect $imageid -f '{{.RepoTags}}')
		echo $imageName
		diffids=$(jq -r '.rootfs.diff_ids[]' "$DOCKERHOME/image/overlay2/imagedb/content/sha256/$imageid") 
		for diffid in $diffids
		do
			diffid=${diffid#sha256:}
			for layerdb_id in $DOCKERHOME/image/overlay2/layerdb/sha256/*
			do
				diff_val=$(cat $layerdb_id/diff)
				diff_val=${diff_val#sha256:}
				if [ $diff_val = $diffid ]; then
					echo " $(basename $layerdb_id)"
				fi
			done
		done
	done 
fi