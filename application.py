import os
import hvac
from flask import Flask

APP = Flask(__name__)


@APP.route('/')
def hello_world():
    return "Hello there :-D"


@APP.route('/foo')
def foo():
    with open('/etc/secret-volume/foo') as open_file:
        return open_file.read()


@APP.route('/bar')
def bar():
    return os.environ['BAR']


@APP.route('/vault')
def vault():
    with open('/vault/secrets/token') as open_file:
        client = hvac.Client(
            url='http://vault.default.svc:8200',
            token=open_file.read().rstrip()
        )

    vault_read_response = client.secrets.kv.v2.read_secret_version(
        path='bar',
    )

    return str(vault_read_response['data']['data']['baz'])


@APP.route('/ping')
def ping():
    return "I'm here!"


if __name__ == '__main__':
    APP.run(host='0.0.0.0', port=5000)
