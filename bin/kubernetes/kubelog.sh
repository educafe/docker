if [ $# -lt 1 ]; then
	while read pod 
	do
		for container in $(kubectl get pods -o jsonpath="{.items[*].spec.containers[*].name}")
		do
			printf "%s\n" "$pod-$container : $(kubectl logs $pod $container)"
		done
	done < <(tail +2 <(kubectl get pods | awk '{print $1}'))
elif [ $1 = '-f' ]; then
	while read pod
	do
		# for container in $(kubectl get pods -o jsonpath="{.items[*].spec.containers[*].name}")
		# do
			kubectl logs -f $pod &
		# done
	done < <(tail +2 <(kubectl get pods | awk '{print $1}'))
elif [ $1 = '-c' ]; then
	while true
	do
		while read pod
		do
			# for container in $(kubectl get pods -o jsonpath="{.items[*].spec.containers[*].name}")
			# do
				tail -1 <(kubectl logs $pod )
			# done
		done < <(tail +2 <(kubectl get pods | awk '{print $1}'))
	echo
	sleep 1
	done
else
	echo "The valid option is only '-f' and '-c'"
fi
