kubectl get pods  -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .spec.containers[*]}{.name}{"\t"}{.image}{"\n"}{end}{end}'