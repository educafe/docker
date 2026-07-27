if [[ $1 == '-k' ]]; then
	while read pid 
	do
		kill -9 $pid
	done < <(head -n -1 <(ps -ef | grep 'kubectl logs -f' | awk '{print $2}'))
elif [[ $1 = '-d' ]]; then
	while read pid 
	do
		kill -9 $pid
	done < <(head -n -1 <(ps -ef | grep 'docker logs -f' | awk '{print $2}'))
else
	echo "Usage : $(basename $0) -d for docker or -k for kubernetes"
fi
