# vault-flask-example

## my environment
* Docker Desktop 2.5.0.1 with k8s enabled
* Helm v3.3.4
* MacOS 10.14.6

This is a bunch of shell scripts to test HashiCorp Vault K8S integration including secret injection. We use the k8s auth method.

This is tested on a Mac with Docker Desktop k8s, and all services are exposed using NodePort.

If you are using a remote k8s cluster you may need to make changes and update the VAULT_ADDR parameter to run the scripts locally.

## local development
We're using a simple Python application to receive HTTP requests and provide responses.
```
pip3 install -r requirements.txt
python3 application.py
```

Take a look at the code in `application.py` to see the request endpoints that we're exposing and what they do.

## steps
### build docker container
```
export docker_user="<your-username>"
docker build -t "${docker_user}/vault-flask-example:0.0.1" .
docker images
```

NOTE: you'll need to edit the deployment manifests with the correct image name.

Then run the shell scripts starting with `01_start_vault.sh`.

`00_start_webapp_with_k8s_secret.sh` is optional. It is the before state of with a k8s secret and without Vault.

For applications that are Vault aware, you can incorporate SDK commands into the app and the sidecar will proxy those to Vault.

```
curl http://localhost:30001
curl http://localhost:30001/foo
curl http://localhost:30001/bar
curl http://localhost:30001/vault
```

## reference

### other demos
* Jason's demo repo: https://github.com/jasonodonnell/vault-agent-demo/

### documentation
* [Agent Sidecar Injector](https://www.vaultproject.io/docs/platform/k8s/injector)
* [Vault Helm Chart](https://www.vaultproject.io/docs/platform/k8s/helm)

### encode/decode the secret
```
base64 <<< "SuperSecr3tValue"
echo 'U3VwZXJTZWNyM3RWYWx1ZQo=' | base64 --decode
```

### updates
* kv v1 has a ttl (https://www.vaultproject.io/docs/secrets/kv/kv-v1#ttls)
* kv v2 ~5 mins (https://github.com/hashicorp/vault/issues/8287)
* dynamic, vault agent uses ttl to track it
