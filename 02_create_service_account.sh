#!/bin/sh
set -o xtrace
# delete before creating
kubectl delete serviceaccount vault-auth
# create service account for k8s auth method
kubectl create serviceaccount vault-auth
# assign auth-delegator cluster role binding to Vault sa
# per https://www.vaultproject.io/docs/auth/kubernetes#configuring-kubernetes
kubectl apply -f CRB-vault-auth-service-account.yaml
