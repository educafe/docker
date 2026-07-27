if [ $(id -u) -eq 0 ]; then
	DOCKERHOME=/var/lib/docker
	FIELD='f6'
else
	DOCKERHOME=$HOME/.local/share/docker
	FIELD='f8'
fi

if [ -z $1 ]; then
	while read containerid
	do
		imageid=$(docker container inspect $containerid -f '{{.Image}}')
		imageid=${imageid#*:}
		container_name=$(docker container inspect $containerid -f '{{.Name}}')
		container_name=${container_name#?}
		echo -e "Container_name: $container_name \t Container_id: $containerid"
		echo " ImageId: $imageid"
		diffid=$(docker image inspect $imageid -f '{{.GraphDriver.Data.UpperDir}}'| cut -d'/' -$FIELD)
		for layerdb in "$DOCKERHOME/image/overlay2/layerdb/sha256/"*; do
				cacheid=$(cat "$layerdb"/cache-id 2>/dev/null)
				if [ $cacheid = $diffid ]; then
					break;
				fi
			done
	done < <(docker ps -aq)

	while read mount
	do
		parent=$(cat $DOCKERHOME/image/overlay2/layerdb/mounts/$mount/parent)
		parent=${parent#*:}
		layerdb=$(basename ${layerdb})
		if [ "$parent" = "$layerdb" ]; then
			echo " MountId: $mount"
			overlay=$(cat $DOCKERHOME/image/overlay2/layerdb/mounts/$mount/mount-id)
			echo " Overlay2: $overlay"
			break;
		fi
	done < <(ls $DOCKERHOME/image/overlay2/layerdb/mounts)
else
	for input in "$@"
	do
		if [[ "$input" =~ ^sha256:[a-f0-9]{64}$ ]]; then
			containerid=${input:0:12}
		elif [[ "$input" =~ ^[a-f0-9]{12}$ ]]; then
			containerid=$input
		else
			containerid=$(docker container inspect $input -f '{{.Id}}')
			containerid=${containerid:0:12}
		fi
	done

	imageid=$(docker container inspect $containerid -f '{{.Image}}')
	imageid=${imageid#*:}
	container_name=$(docker container inspect $containerid -f '{{.Name}}')
	container_name=${container_name#?}
	echo -e "Container_name: $container_name \t Container_id: $containerid"
	echo " ImageId: $imageid"
	diffid=$(docker image inspect $imageid -f '{{.GraphDriver.Data.UpperDir}}'| cut -d'/' -$FIELD)
	for layerdb in "$DOCKERHOME/image/overlay2/layerdb/sha256/"*; do
		cacheid=$(cat "$layerdb"/cache-id 2>/dev/null)
		if [ $cacheid = $diffid ]; then
			break;
		fi
	done
		
	while read mount
	do
		layer_db=$(cat $DOCKERHOME/image/overlay2/layerdb/mounts/$mount/parent)
		layer_db=${layer_db#*:}
		layerdb=$(basename ${layerdb})
		if [ "$layer_db" = "$layerdb" ]; then
			echo " MountId: $mount"
			overlay=$(cat $DOCKERHOME/image/overlay2/layerdb/mounts/$mount/mount-id)
			echo " Overlay2: $overlay"
			break;
		fi
	done < <(ls $DOCKERHOME/image/overlay2/layerdb/mounts)
fi


