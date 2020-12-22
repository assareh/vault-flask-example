#!/bin/sh
set -o xtrace

export VAULT_ADDR=http://localhost:30000
export VAULT_TOKEN=root

# read values from the vault sa in k8s to write the k8s auth config in vault
export VAULT_SA_NAME=$(kubectl get sa vault-auth \
     -o jsonpath="{.secrets[*]['name']}")
export SA_JWT_TOKEN=$(kubectl get secret $VAULT_SA_NAME \
     -o jsonpath="{.data.token}" | base64 --decode; echo)
export SA_CA_CRT=$(kubectl get secret $VAULT_SA_NAME \
     -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)
export K8S_URL="https://kubernetes:443"

# enable k8s auth method
vault auth enable kubernetes

# configure with values extracted from the sa
vault write auth/kubernetes/config \
        token_reviewer_jwt="$SA_JWT_TOKEN" \
        kubernetes_host="$K8S_URL" \
        kubernetes_ca_cert="$SA_CA_CRT"

# create a new role for sidecar to use
vault write auth/kubernetes/role/default-vault-flask-example \
        bound_service_account_names=vault-flask-example \
        bound_service_account_namespaces=default \
        policies=vault-flask-example \
        ttl=1m
