if [ $(id -u) -eq 0 ]; then
	DOCKERHOME=/var/lib/docker
	FIELD='f6'
else
	DOCKERHOME=$HOME/.local/share/docker
	FIELD='f8'
fi

if [ $# -lt 1 ]; then
	jq '.Repositories' $DOCKERHOME/image/overlay2/repositories.json
else
	jq -r '.Repositories["'$1'"]' $DOCKERHOME/image/overlay2/repositories.json
fi
