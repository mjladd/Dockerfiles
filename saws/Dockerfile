# Container for SAWS AWS CLI
# https://github.com/donnemartin/saws

FROM alpine:latest
MAINTAINER Michael Ladd <mladd@leapfrogonline.com>

RUN apk add --no-cache \
    groff python3 \
    && python3 -m ensurepip \
    && python3 -m pip install --upgrade pip setuptools saws 

ENTRYPOINT ["saws"]




