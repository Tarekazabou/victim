kubectl logs -n falco -l app.kubernetes.io/name=falco -f --all-containers \
  | grep --line-buffered '^{' \
  | ./bin/kubesentinel monitor-stdin