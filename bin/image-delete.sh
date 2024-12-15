#!/bin/bash

if [ $# -lt 2 ]; then
	echo "Usage : $0 <container-name> <registry-url> <image_name:tag>"
	exit
fi

REGISTRY="$1"
REGISTRY_URL="$2"
REPOSITORY="$3"

# Get all tags
TAGS=$(curl -s -X GET http://$REGISTRY_URL/v2/$REPOSITORY/tags/list \
  | jq -r '.tags[]')

# Delete each tag
for TAG in $TAGS; do
  # Get the manifest digest
  DIGEST=$(curl -s -I \
    -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    http://$REGISTRY_URL/v2/$REPOSITORY/manifests/$TAG \
    | grep Docker-Content-Digest \
    | awk '{print $2}' \
    | tr -d $'\r')

  echo "Deleting $REPOSITORY:$TAG with digest $DIGEST"

  # Delete the manifest
  curl -s -X DELETE \
    http://$REGISTRY_URL/v2/$REPOSITORY/manifests/$DIGEST
done

docker exec $1 registry garbage-collect /etc/docker/registry/config.yml

