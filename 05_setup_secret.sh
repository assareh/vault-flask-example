#!/bin/sh
set -o xtrace

export VAULT_ADDR=http://localhost:30000
export VAULT_TOKEN=root

vault kv put secret/foo key='This is a secret retrieved from HashiCorp Vault and rendered to a shared memory volume!'
vault kv put secret/bar key='This is a secret retrieved from HashiCorp Vault and provided as an environment variable!' \
                        baz='This is a secret retrieved from HashiCorp Vault directly by an API call!'

# create policy for the example app to be able to access secrets
vault policy write vault-flask-example vault-flask-example.hcl
