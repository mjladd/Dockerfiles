# Dockerize SSHD daemon for ssh tunnel

## Backgroud

### What is SSH Tunneling / Port Forwarding

- aka, port forwarding
- A method for creating an encrypted SSH connection b/w a client and server machine, through which service ports can be relayed
- The encrypted SSH tunnel is used to allow other network traffic to pass inside of the tunnel
- SSH forwarding is useful for transporting network data that typically used an unencrypted protocol, accessing geo-restricted content, or bypassing intermediate firewalls

#### Three Types of SSH port forwarding

- local port forwarding : forwards a connection from the client host to the SSH server and then to its destination port
- remote port forwarding : forwards a port from the server to the client host and then to the destination port
- dynamic port forwarding : creates a SOCKS proxy that allows communication across a range of ports

#### Local Port Forwarding

- allows you to create a local port that is forwarded to a remote port ... what does this mean ...

### Sidebar: what is a port

- a port is an addressable network location implemented in an operating system to differentiate traffic destined for different services or applications
- a port is always associated with an IP address of a host and the protocol type for communication
- listening : a service is "listening" when it it bound to a port/protocol/IP address and waiting for clients to request the service

NOTE: `lsof -i # list all open ports`

For SSH tunnelling, it is releveant to know that the *ssh* service listens on port 22 by default.

```shell
➜  notebooks git:(main) ✗ lsof -i | grep ssh
ssh       99649 mladd    4u  IPv4 0x4903d034de57b337      0t0  TCP 10.0.0.14:59303->10.0.0.22:ssh (ESTABLISHED)
ssh       99649 mladd    5u  IPv4 0x4903d034de57b337      0t0  TCP 10.0.0.14:59303->10.0.0.22:ssh (ESTABLISHED)
```

### Port Categories

- 0-1023 : well known port, associated with services that are considered to be critical/essential (aka, System Ports)
- 1024-49151 : registered ports / user ports, their usage can be reserved by a request to IANA (Internet Assignned Numbers Authority)
- 49152-65535 : dynamic ports, suggested for private usage

NOTE : `cat /etc/services` -> list of well known and registered ports

### Local Port Forwarding Example

- Let's say we have a webserver hosting a page that is only available via the loopback adapter
- A loopback adapter is a virtual network interface that a system uses to communicate with itself
- This means you have to be on this remote server in order to access the webpage
- If we are able to ssh into the remote server, we can create a local port that gets forwarded to the remote webserver

```shell
# loopback
➜  notebooks git:(main) ✗ ifconfig | grep lo0
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384

# first network adapter
➜  notebooks git:(main) ✗ ifconfig | grep en0
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        inet6 fe80::18fc:11ac:a9fe:dc56%en0 prefixlen 64 secured scopeid 0xf


➜  notebooks git:(main) ✗ ifconfig
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
        options=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>
        inet 127.0.0.1 netmask 0xff000000
        inet6 ::1 prefixlen 128
        inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
        inet 127.0.0.5 netmask 0xff000000
        nd6 options=201<PERFORMNUD,DAD>
```

```shell
# on remote host, zorn
➜  ~ python3 -m http.server 8080
Serving HTTP on 0.0.0.0 port 8080 (http://0.0.0.0:8080/) ...
10.0.0.14 - - [18/Jan/2024 22:23:21] "GET / HTTP/1.1" 200 -
10.0.0.14 - - [18/Jan/2024 22:23:21] code 404, message File not found
10.0.0.14 - - [18/Jan/2024 22:23:21] "GET /favicon.ico HTTP/1.1" 404 -

# test on local host w/ browser
http://10.0.0.22:8080

# test via CLI
➜  notebooks git:(main) ✗ nc -zv 10.0.0.22 8080
Connection to 10.0.0.22 port 8080 [tcp/http-alt] succeeded!

# on remote host, zorn
➜  ~ python3 -m http.server -b 127.0.0.1 8080
Serving HTTP on 127.0.0.1 port 8080 (http://127.0.0.1:8080/) ...

# test with browser locally
Unable to connnect

# test via CLI
➜  notebooks git:(main) ✗ nc -zv 10.0.0.22 8080
nc: connectx to 10.0.0.22 port 8080 (tcp) failed: Connection refused

# test via CLI on remote host
➜  ~ hostname
zorn
➜  ~ nc -zv 127.0.0.1 8080
Connection to 127.0.0.1 8080 port [tcp/http-alt] succeeded!

```

### Local Port Forwarding Again

- allows you to create a local port that is forwarded to a remote port

```shell
ssh -N -f -L 28080:127.0.0.1:8080 mladd@10.0.0.22

# -N : do NOT execute a remote command, without this flag you would get a shell on the remote server
# -f : send SSH to the background (daemonize)
# -L : tell SSN to forward a local port
# 288080:127.0.0.1:8080 : bind local port `208080` on localhost (127.0.0.1) to the remote port `8080`
# mladd@10.0.0.22 : tell SSH to log in to the remote server as the specified user to establish a SSH tunnel
#                 : port 208080 on the loopback interface is bound to port 80 on the remote host
#                 : any traffic on 127.0.0.1:208080 is now forwarded to the remote host on port 80
```

#### Remote Port Forwarding

- remote port forwarding is the opposite of local port forwarding
- let's again say we have a webserver that is only listening on a loopback adapter
- let's also assume that our local workstation cannot directly reach the remote host where the webserver is running
- there is an intermediate host that is reachable by both our local workstation and the remote host


```shell

```

### Reverse SSH tunnel

- forward a port by connecting as a cliet to a SSH server managed by Hightouch.
- rather than the traditional connection from a local machine to a remote server, reverse SSH tunneling establishes a connection from the remote server to the local machine
- used to gain access to a local machine that is behind a firewall or NAT

### What is Reverse SSH Tunneling

- Reverse SSH Tunneling is a technique to establish a secure connection from a remote server back to a local machine.
- Rather than connecting from a local machine to a remote server, reverse SSH tunneling establishes a connection from the remote server to the local machine.

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

# test if tunnel is up

nc -z hostname.here 22 || echo "no tunnel open"

```

## autossh

<https://github.com/Autossh/autossh>

## References

- [ ] <https://betterprogramming.pub/running-a-container-with-a-non-root-user-e35830d1f42a>
- [ ] <https://gdevillele.github.io/engine/admin/using_supervisord/>
- [ ] <https://docs.docker.com/config/containers/multi-service_container/>
- [ ] <https://linuxize.com/post/how-to-setup-ssh-tunneling/>
- [ ] <https://qbee.io/misc/reverse-ssh-tunneling-the-ultimate-guide/>
- [ ] <https://grahamhelton.com/blog/ssh-cheatsheet/>
