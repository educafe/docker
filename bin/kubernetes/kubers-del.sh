while read rs
do
	kubectl delete rs $(basename $rs)
done < <(kubectl get rs -o=name)
	