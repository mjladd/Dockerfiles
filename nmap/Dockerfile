# Alpine / Py3 / Insecure / Jupyter
# Mostly from: https://hub.docker.com/r/pshchelo/alpine-jupyter-minimal-py3/
# adds matplotlib and insecure token

FROM alpine:latest
MAINTAINER Michael Ladd (mjladd@gmail.com)

RUN apk --no-cache add nmap lua nmap-nselibs

ENTRYPOINT [ "nmap" ]

