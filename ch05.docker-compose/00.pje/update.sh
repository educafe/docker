repeat=0
while true
do
	echo "This is repeat count - ($repeat)" | tee file01
	repeat=$[$repeat + 1]
	sleep 5
done
