if [ $# -lt 1 ]; then
	echo "Usage: $(basename $0) <pod_name>"
	exit
fi
container_id=$(kubectl get pod $1 -n kube-system -o jsonpath='{.status.containerStatuses[].containerID}' | sed 's/^.*://')
docker inspect $container_id -f '{{.GraphDriver.Data.MergedDir}}'
