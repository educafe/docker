function signal_handler {
	stdbuf -i0 -o0 -e0 echo "Signal $1 is trapped by $(uname -n) at $(hostname -I)"
}

trap "signal_handler SIGINT" INT
trap "signal_handler SIGQUIT" QUIT
trap "signal_handler SIGTERM" TERM
trap "echo Good Bye" EXIT
i=0
while true
do
	stdbuf -i0 -o0 -e0 echo "$(uname -n) at $(hostname -I) -- Hello Kubernetes -- $i"
	i=$[$i + 1]
	sleep 5
done
