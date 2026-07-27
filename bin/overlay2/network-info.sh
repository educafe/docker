while read networkid
do
	if [ "$(docker network inspect $networkid -f '{{.Name }}')" != host \
		-a "$(docker network inspect $networkid -f '{{.Name }}')" != none	]; then
		printf "%-15s" $(docker network inspect $networkid -f '{{.Name }}')
		docker network inspect $networkid -f '{{json .IPAM.Config}}'
	fi
done < <(docker network ls -q)


