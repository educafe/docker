if [ $# -lt 1 ]; then
	while read pod 
	do
		printf "%s\n" "$pod : $(kubectl logs $pod)"
	done < <(tail +2 <(kubectl get pods | awk '{print $1}'))
elif [ $1 = '-f' ]; then
	while read pod
	do
		kubectl logs -f $pod &
	done < <(tail +2 <(kubectl get pods | awk '{print $1}'))
elif [ $1 = '-c' ]; then
	while true
	do
		while read pod
		do
			tail -1 <(kubectl logs $pod)
		done < <(tail +2 <(kubectl get pods | awk '{print $1}'))
	echo
	sleep 1
	done
else
	echo "The valid option is only '-f' and '-c'"
fi
