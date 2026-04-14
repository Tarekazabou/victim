cd ~/kubesentinel

# Build the new Go CLI image
docker build -f dockerfile -t kubesentinel:latest .

# Load it into Minikube
minikube image load kubesentinel:latest

# kubectl apply -f deploy/kubesentinel-runtime.yaml

kubectl apply -f deploy/kubesentinel-daemonset.yaml

cd ~/kubesentinel

# Build the AI image using the correct Dockerfile
docker build -f dockerfile.ai -t kubesentinel-ai:latest .

# Load the fixed image into Minikube
minikube image load kubesentinel-ai:latest

kubectl rollout restart deployment kubesentinel-ai -n kubesentinel
kubectl get pods -n kubesentinel -w
