while read containerid
do
	docker kill --signal=2 $containerid
done < <(docker ps -q)