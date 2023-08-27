while read pod
do
	kubectl delete pod $(basename $pod)
done < <(kubectl get pods -o=name)
	