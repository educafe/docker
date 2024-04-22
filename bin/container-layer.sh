if [ $# -lt 1 ]; then
	echo "Usage : $(basename $0) <container-id>"
	exit
else
	docker container inspect $1 | grep Upper | cut -d '/' -f6
fi