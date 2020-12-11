#!/bin/sh
set -o xtrace

export VAULT_ADDR=http://localhost:30000
export VAULT_TOKEN=root

vault kv put secret/foo key='This is a secret retrieved from HashiCorp Vault!'

# create policy for the example app to be able to access secrets
vault policy write vault-flask-example vault-flask-example.hcl
