FROM python:3.11-slim-bookworm

RUN apt update && \
    apt upgrade -y

RUN apt install gcc -y

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

ENV PYTHONBUFFERED=TRUE
