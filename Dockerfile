FROM python:3.7-slim

COPY requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

COPY application.py ./application.py

ENTRYPOINT ["python3", "application.py"]