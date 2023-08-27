function signal_handler {
	stdbuf -i0 -o0 -e0 echo "Signal $1 is trapped by $(uname -n) at $(hostname -I)"
}

for i in {1..31}
do 
	if [ $i -ne 17 ]; then
		trap "signal_handler $i" $i
	fi
done
i=0
while true
do
	stdbuf -i0 -o0 -e0 echo "$(uname -n) at $(hostname -I) -- Hello Docker -- $i"
	i=$[$i + 1]
	sleep 5
done
