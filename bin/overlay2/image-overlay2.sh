if [ $(id -u) -eq 0 ]; then
	DOCKERHOME=/var/lib/docker
	FIELD='f6'
else
	DOCKERHOME=$HOME/.local/share/docker
	FIELD='f8'
fi

if [ -z $1 ]; then
	for imageid in $(docker image ls -q)
	do
		imageName=$(docker image inspect $imageid -f '{{.RepoTags}}')
		echo -e  "$imageName: $imageid"
		notrunc_imageid=$(docker image inspect -f '{{.Id}}' $imageid)
		notrunc_imageid=${notrunc_imageid#sha256:}
		diffids=$(jq -r '.rootfs.diff_ids[]' "$DOCKERHOME/image/overlay2/imagedb/content/sha256/$notrunc_imageid")
		for diffid in $diffids
		do
			diffid=${diffid#sha256:}
			for layerdb_id in $DOCKERHOME/image/overlay2/layerdb/sha256/*
			do
				diff_val=$(cat $layerdb_id/diff)
				diff_val=${diff_val#sha256:}
				if [ $diff_val = $diffid ]; then
					cacheid=$(cat "$layerdb_id"/cache-id 2>/dev/null)
					layerdb_id=$(basename $layerdb_id);
					for overlay_id in "$DOCKERHOME/overlay2/"*
					do
						overlay_id=$(basename $overlay_id)
						if [ "$cacheid" = "$overlay_id" ]; then
							# echo -e " LayerDB: \t$(basename "$layerdb_id")"
							echo -e "\t$cacheid"
						fi
					done
				fi
			done
					
		done
	done
	# printf '\033[1A\033[2K' 		#\033[1A  → move cursor up one line
															# \033[2K  → erase entire current line
else
	for input in "$@"
	do
		imageid=$(docker image ls -q $input)
		imageName=$(docker image inspect $imageid -f '{{.RepoTags}}')
		echo "$imageName: $imageid"
		notrunc_imageid=$(docker image inspect -f '{{.Id}}' $imageid)
		notrunc_imageid=${notrunc_imageid#sha256:}
		diffids=$(jq -r '.rootfs.diff_ids[]' "$DOCKERHOME/image/overlay2/imagedb/content/sha256/$notrunc_imageid")
		for diffid in $diffids
		do
			diffid=${diffid#sha256:}
			for layerdb_id in $DOCKERHOME/image/overlay2/layerdb/sha256/*
			do
				diff_val=$(cat $layerdb_id/diff)
				diff_val=${diff_val#sha256:}
				if [ $diff_val = $diffid ]; then
					# echo " $(basename $layerdb_id)"
					cacheid=$(cat "$layerdb_id"/cache-id 2>/dev/null)
					layerdb_id=$(basename $layerdb_id);
					# cacheid=$(cat "$layerdb_id"/cache-id 2>/dev/null)
					for overlay_id in "$DOCKERHOME/overlay2/"*
					do
						# cacheid=$(cat "$layerdb_id"/cache-id 2>/dev/null)
						overlay_id=$(basename $overlay_id)
						if [ "$cacheid" = "$overlay_id" ]; then
							# echo -e " LayerDB: \t$(basename "$layerdb_id")"
							echo -e "\t$cacheid"
						fi
					done
				fi
			done
		done
	done
	# tput cuu1   # cursor up one
	# tput el			# clear to end of that line
fi