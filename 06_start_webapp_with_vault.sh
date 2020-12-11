#!/bin/sh
set -o xtrace

# delete sa before creating
kubectl delete serviceaccount vault-flask-example

# create sa
kubectl create serviceaccount vault-flask-example

# deleting before creating
kubectl delete -f deployment_with_vault.yaml

# app with vault annotations
kubectl apply -f deployment_with_vault.yaml

sleep 5

# tail the init container
kubectl logs -f $(kubectl get pods -l app=vault-flask-example -o name) vault-agent-init

# exec into the app container
kubectl exec -i -t $(kubectl get pod -l app=vault-flask-example -o name) vault-flask-example -- /bin/bash

# tail the sidecar
kubectl logs -f $(kubectl get pods -l app=vault-flask-example -o name) vault-agent