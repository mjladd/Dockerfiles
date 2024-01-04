# ECR demo

## Build a docker image

```shell
docker build -t hello .
docker images --filter reference=hello

hello git:(master) ✗ docker images --filter reference=hello
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
hello        latest    e807eeeee81b   3 weeks ago   7.73MB

docker run -it hello
Hello there General Kenobi!

```

## Authenticate to AWS ECR

```shell
➜  hello git:(master) ✗ assume

? Please select the profile you would like to assume: ptc-gbl-artifacts-data-eng
If browser is not opened automatically, please open link:
https://device.sso.us-east-1.amazonaws.com/?user_code=BSGC-ZVXX

Awaiting authentication in the browser...

[ptc-gbl-artifacts-data-eng](us-east-1) session credentials will expire 2024-01-03 23:27:09 -0600 CST
➜  hello git:(master) ✗

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 601730047828.dkr.ecr.us-east-1.amazonaws.com/data-science-models
```

## Push image to AWS ECR

```shell
docker tag hello:latest 601730047828.dkr.ecr.us-east-1.amazonaws.com/data-science-models
```
