# Dockerize SSHD daemon for ssh tunnel

## Backgroud

### Reverse SSH tunnel

- forward a port by connecting as a cliet to a SSH server managed by Hightouch.
- rather than the traditional connection from a local machine to a remote server, reverse SSH tunneling establishes a connection from the remote server to the local machine
- used to gain access to a local machine that is behind a firewall or NAT

### How

Consider two machines `LocalMachine` (behind a firewall) and `RemoteServer`. The goal is to SSH into the `LocalMachine` from the `RemoteServer`. The `LocalMachine` initiates a connection the `RemoteServer` and sets up a tunnel. Once the tunnel is established, one can connect to the Local Machine by connecting to the tunnel from `RemoteServer`.

```shell
# On LocalMachine
ssh -R 9000:localhost:22 user@RemoteServer

# On RemoteServer
ssh -p 9000 user@localhost
```

## TODO

- [ ] add auth key for vendor
- [ ] test tunnel to local host (ex. zorn)
- [ ] maybe add non-root user?

## MISC

- generate SSH key

`ssh-keygen -t ed25519 -c 'docker-test-key`

## Build

`docker build --progress=plain --no-cache -t sshd_tunnel .`

## Run Locally

`docker run -it sshd_tunnel /bin/bash`

## Run as Daemon

`docker run -d -p 7822:7822 --name hightouch_ssh sshd_tunnel`

## Connect

`ssh -o StrictHostKeyChecking=no  -i ./hightouch_ed25519 root@localhost -p 782`

## Cleanup

```shell
docker stop hightouch_ssh
docker rm hightouch_ssh
docker rmi sshd_tunnel
```

## SSH command

```shell
ssh -i path/to/key.pem \
    -R 0.0.0.0:56000:$SERVICE_HOST:$SERVICE_PORT \
    tunnel.hightouch.io -p 49100 \
    -o ExitOnForwardFailure=yes```
```

## Conection Test

```shell
# on remote node
# specify to listen on port 9595
python3 -m http.server 9595

# on local node
http://10.0.0.22:9595

# test with ssh tunnel
# -b : bind to IP addr
python3 -m http.server  -b 127.0.0.1 8080

# test connection
wget -p 10.0.0.22:9595 # remote
wget -p 127.0.0.1:9595 # local, after binding to localhost

# on local node - establish tunnel

```

## References

- [ ] <https://betterprogramming.pub/running-a-container-with-a-non-root-user-e35830d1f42a>
- [ ] <https://gdevillele.github.io/engine/admin/using_supervisord/>
- [ ] <https://docs.docker.com/config/containers/multi-service_container/>
- [ ] <https://linuxize.com/post/how-to-setup-ssh-tunneling/>
- [ ] <https://qbee.io/misc/reverse-ssh-tunneling-the-ultimate-guide/>
