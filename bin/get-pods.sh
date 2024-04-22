if [ -z $1 ]; then
	kubectl get pods -o custom-columns=NAME:.metadata.name,IP:.status.podIP,NODE:.spec.nodeName,RESTARTS:.status.restartCount,STATUS:.status.phase,IMAGE:.spec.containers[*].image
else
	kubectl get pods $1 -o custom-columns=NAME:.metadata.name,IP:.status.podIP,NODE:.spec.nodeName,RESTARTS:.status.restartCount,STATUS:.status.phase,IMAGE:.spec.containers[*].image
	
fi

