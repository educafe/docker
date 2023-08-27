while read node
do
	printf %s "$(docker node inspect $node -f '{{ .Description.Hostname }}') : "
	docker node inspect $node -f '{{ .Status.Addr }}'
done < <(docker node ls -q)

