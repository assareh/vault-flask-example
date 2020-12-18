#!/bin/sh
set -o xtrace

# delete sa before creating
kubectl delete serviceaccount vault-flask-example

# create sa
kubectl create serviceaccount vault-flask-example

# deleting before creating
kubectl delete -f secret.yaml
kubectl apply -f secret.yaml

# deleting before creating
kubectl delete -f deployment.yaml
kubectl apply -f deployment.yaml

kubectl get deployments vault-flask-example
kubectl get pods
kubectl get secret test-secret
sleep 6

# open browser window
# echo 'open app'
# open http://localhost:30001

echo 'exec into the container and check the k8s secret at /etc/secret-volume'
kubectl exec -i -t $(kubectl get pod -l app=vault-flask-example -o jsonpath="{.items[0].metadata.name}") -- /bin/ash
