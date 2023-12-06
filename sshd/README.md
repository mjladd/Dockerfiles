# Dockerize SSHD daemon for ssh tunnel

## TODO

- [ ] include creds in .env file
- [ ] add auth key for vendor

## MISC

- generate SSH key

`ssh-keygen -t ed25519 -c 'docker-test-key`

## Build

`docker build --progress=plain --no-cache -t sshd_tunnel .`

## Run Locally

`docker run -it sshd_tunnel /bin/bash`

## Run as Daemon

`docker run -d -p 7822:7822 --name hightouch_ssh sshd_tunnel`

## Cleanup

```shell
docker stop hightouch_ssh
docker rm hightouch_ssh
docker rmi sshd_tunnel
```