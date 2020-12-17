#!/bin/sh
set -o xtrace

# delete sa before creating
kubectl delete serviceaccount vault-flask-example

# create sa
kubectl create serviceaccount vault-flask-example

# deleting before creating
kubectl delete -f deployment.yaml
kubectl delete -f deployment_with_vault.yaml

# app with vault annotations
kubectl apply -f deployment_with_vault.yaml

sleep 5

POD=$(kubectl get pod -l app=vault-flask-example -o jsonpath="{.items[0].metadata.name}")

# tail the init container
echo 'tail the init container logs'
kubectl logs -f $POD vault-agent-init

# exec into the app container
echo 'exec into the app container'
kubectl exec -i -t $POD vault-flask-example -- /bin/ash

# tail the app container logs
echo 'tail the app container logs'
kubectl logs -f $POD vault-flask-example

# tail the sidecar
echo 'tail the sidecar container logs'
kubectl logs -f $POD vault-agent

# open browser windows
echo 'open vault'
open http://localhost:30000
echo 'open app'
open http://localhost:30001