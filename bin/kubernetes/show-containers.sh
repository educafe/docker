kubectl get pods -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n'
echo
kubectl get pods -o jsonpath="{.items[*].spec.containers[*].name}" | tr -s '[[:space:]]' '\n'
echo
