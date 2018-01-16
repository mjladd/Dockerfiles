FROM alpine:latest

RUN apk --no-cache add ca-certificates \
        python3 \
        && pip3 install awscli \
        && mkdir -p /root/.aws

ENTRYPOINT [ "aws" ]

