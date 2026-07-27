#!/bin/sh
if [ $# -lt 1 ]; then
	echo "Usage : $(basename $0) <container name or id>"
	exit
fi

docker container inspect --format \
' Container={{.Id}}
 ImageConfig={{.Image}}
 ImageName='{{.Config.Image}}'
 Manifest={{.ImageManifestDescriptor.digest}}
 Storage={{json .Storage}}' \
"$1"
