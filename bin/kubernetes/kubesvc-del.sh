while read svc
do
	kubectl delete svc $(basename $svc)
done < <(kubectl get svc -o=name)
	