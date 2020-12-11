from flask import Flask

app = Flask(__name__)


def run_example():
    with open('/etc/secret-volume/secret') as file:
        return file.read()


@app.route('/')
def hello_world():
    try:
        return run_example()
    except Exception as err:
        return str(err)


@app.route('/ping')
def ping():
    return "Hello world"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
