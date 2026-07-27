while read networkid
do
	if [ "$(docker network inspect $networkid -f '{{.Name }}')" != host \
		-a "$(docker network inspect $networkid -f '{{.Name }}')" != none	]; then
		printf "%s" $(docker network inspect $networkid -f '{{.Name}}') 
		docker network inspect $networkid -f \
		':{{range.Containers}} {{.Name}} {{.IPv4Address}} {{end}}'
	fi
done < <(docker network ls -q)