#### encode/decode the secret
```
base64 <<< "SuperSecr3tValue"
echo 'U3VwZXJTZWNyM3RWYWx1ZQo=' | base64 --decode
```

#### 01_deploy_app.sh
```
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl get deployments vault-flask-example
kubectl get pods
kubectl get secret test-secret
kubectl exec -i -t $(kubectl get pod -l app=vault-flask-example -o name) -- /bin/bash
```

#### view secret in pod
```
cd /etc/secret-volume
ls
cat secret
```

#### 02_start_vault.sh
#### 03_create_service_account.sh
#### 04_configure_k8s_auth_method.sh
#### 05_setup_secret.sh

#### create a service account for the sidecar to use
```
kubectl create serviceaccount vault-flask-example
```

#### 06_start_webapp_with_vault.sh

We can delegate the auth to the sidecar, and incorporate SDK commands into our app if we want using the token provided.

#### 07_destroy.sh
```
kubectl delete -f deployment.yaml
kubectl delete -f secret.yaml
```

# updates
* kv v1 has a ttl (https://www.vaultproject.io/docs/secrets/kv/kv-v1#ttls)
* kv v2 ~5 mins (https://github.com/hashicorp/vault/issues/8287)
* dynamic, vault agent uses ttl to track it
