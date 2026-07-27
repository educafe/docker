while read containerid
do
	printf "%s" $(docker inspect $containerid -f '{{.Name}}')
	docker inspect $containerid \
	-f ':{{range.NetworkSettings.Networks}} {{.IPAddress }}{{end}}'
done < <(docker ps -q)

