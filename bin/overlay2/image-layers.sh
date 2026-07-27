#!/bin/bash
if [ $(id -u) -eq 0 ]; then
	DOCKERHOME=/var/lib/docker
else
	DOCKERHOME=$HOME/.local/share/docker
fi

find-next-layer() {
	while read image
	do
		# echo "BOTTOM="$image
		if [ ! -f $DOCKERHOME/image/overlay2/layerdb/sha256/$image/parent ]; then
			echo "Image Layer: "
			echo "BOTTOM="$image
			continue
		fi
		parent=$(cat $DOCKERHOME/image/overlay2/layerdb/sha256/$image/parent | awk -F: '{print $2}')
		if [ "$parent" = "$1" ]; then
			echo "UPPER=$image"
			find-next-layer $image
		fi
	done < <(ls $DOCKERHOME/image/overlay2/layerdb/sha256)
}

while read image
do
	if [ ! -f $DOCKERHOME/image/overlay2/layerdb/sha256/$image/parent ]; then
		find-next-layer $image
		echo
	fi
done < <(ls $DOCKERHOME/image/overlay2/layerdb/sha256)
tput cuu1
tput el
