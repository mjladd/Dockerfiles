FROM alpine:latest

WORKDIR /unzip
ENTRYPOINT ["unzip"]
RUN apk add -u unzip && rm -fr /var/cache/apk/*

