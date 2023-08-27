while read deploy
do
	kubectl delete deploy $(basename $deploy)
done < <(kubectl get deploy -o=name)
	