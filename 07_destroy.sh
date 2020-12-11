#!/bin/sh
# destroy all resources
kubectl delete -f deployment.yaml
kubectl delete -f secret.yaml
kubectl delete -f CRB-vault-auth-service-account.yaml
kubectl delete serviceaccount vault-flask-example
kubectl delete serviceaccount vault-auth
helm delete vault
