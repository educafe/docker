if [ -z $1 ]; then
	pods=$(kubectl get pods -o wide | awk '{print $1}' | tail +2)
	for pod in $pods
	do
		echo -n "PODNAME: "$pod
		ip=$(kubectl get pods $pod -o wide | awk '{print $6}' | tail +2)
		node=$(kubectl get pods $pod -o wide | awk '{print $7}' | tail +2)
		if [[ $ip =~ \)$ ]]; then 
			ip=$(kubectl get pods $pod -o wide | awk '{print $8}' | tail +2)
			node=$(kubectl get pods $pod -o wide | awk '{print $9}' | tail +2)
		fi	
		echo -e "\t\tIP: $ip\t\tNODE: $node"
		containers=$(kubectl get pods $pod -o jsonpath='{.spec.containers[*].name}')
		images=$(kubectl get pods $pod -o jsonpath='{.spec.containers[*].image}')
		
		for container in $containers
		do
			echo $container >> containers
		done
		
		for image in $images
		do
			echo $image >> images
		done
		
		paste containers images
		rm containers images
	done
else
	containers=$(kubectl get pods $1 -o jsonpath='{.spec.containers[*].name}')
	images=$(kubectl get pods $1 -o jsonpath='{.spec.containers[*].image}')
	
	echo "PODNAME: "$1
	for container in $containers
	do
		echo $container >> containers
	done
	
	for image in $images
	do
		echo $image >> images
	done
	
	paste containers images
	rm containers images
fi



# for container in $containers
# do
	# echo $container >> containers
# done

# for image in $images
# do
	# echo $image >> images
# done

# paste containers images

# rm pods containers images