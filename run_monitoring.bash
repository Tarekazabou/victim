#open port 8080 for kubesentinel monitoring
kubectl logs -n falco -l app.kubernetes.io/name=falco -f --all-containers \
  | grep --line-buffered '^{' \
  | ./bin/kubesentinel monitor-stdin

fuser -k 8080/tcp
fuser -k 5000/tcp
#kubectl port-forward svc/kubesentinel-ai -n kubesentinel 8080:5000 &
kubectl port-forward svc/kubesentinel-ai -n kubesentinel 5000:5000 &