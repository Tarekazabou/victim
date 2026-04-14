kubectl port-forward --address 0.0.0.0 svc/kubesentinel-ai 30500:5000 -n kubesentinel

sudo ufw allow 30500/tcp

# Check if the port forwarding is working
FALCO_POD=$(kubectl get pod -n falco -l app=falco -o jsonpath='{.items[0].metadata.name}')
echo "Using pod: $FALCO_POD"
kubectl logs -f -n falco "$FALCO_POD" | ./kubesentinel monitor-stdin
