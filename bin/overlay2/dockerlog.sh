	while read containerid
	do
		docker logs -f $containerid &
	done < <(docker ps | awk '{print $NF}'| tail +2)

