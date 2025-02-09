#!/bin/bash
IMAGELAYERHOME=/var/lib/docker/image/overlay2/layerdb/sha256
find-next-layer() {
	while read image
	do
		if [ ! -f $IMAGELAYERHOME/$image/parent ]; then
			continue
		fi
		parent=$(cat $IMAGELAYERHOME/$image/parent | awk -F: '{print $2}')
		if [ "$parent" = "$1" ]; then
			echo $image
			# tput setaf 2
			# echo " diff_id=$(cat $IMAGELAYERHOME/$image/diff | awk -F: '{print $2}')"
			# tput setaf 0
			find-next-layer $image
		fi
	done < <(ls $IMAGELAYERHOME)
}

while read image
do
	if [ ! -f $IMAGELAYERHOME/$image/parent ]; then
		echo
		echo "baseLayer="$image
		find-next-layer $image
	fi
done < <(ls $IMAGELAYERHOME)
