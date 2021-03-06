FROM alpine:latest

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

COPY requirements.txt ./requirements.txt
RUN pip3 install -r requirements.txt
COPY application.py ./application.py

# ENTRYPOINT ["python3", "-u", "./application.py"]