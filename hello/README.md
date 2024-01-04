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

# the ECR repos live in the artifacts account
? Please select the profile you would like to assume: ptc-gbl-artifacts-data-eng

[ptc-gbl-artifacts-data-eng](us-east-1) session credentials will expire 2024-01-03 23:27:09 -0600 CST
➜  hello git:(master) ✗

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 601730047828.dkr.ecr.us-east-1.amazonaws.com/ds-lifetime-model

Login Succeeded
```

## Push image to AWS ECR

```shell
docker tag hello:latest 601730047828.dkr.ecr.us-east-1.amazonaws.com/ds-lifetime-model

# there is now an image tagged with the repo repository
➜  hello git:(master) ✗ docker images
REPOSITORY                                                           TAG       IMAGE ID       CREATED       SIZE
hello                                                                latest    e7b19fd1b455   3 weeks ago   7.73MB
601730047828.dkr.ecr.us-east-1.amazonaws.com/ds-segmentation-model   latest    e7b19fd1b455   3 weeks ago   7.73MB

docker push 601730047828.dkr.ecr.us-east-1.amazonaws.com/ds-lifetime-model
```

## Pull image from AWS ECR

```shell

# remove all local images to verify pull
➜  hello git:(master) ✗ docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE


➜  hello git:(master) ✗ docker pull 601730047828.dkr.ecr.us-east-1.amazonaws.com/ds-lifetime-model

➜  hello git:(master) ✗ docker images

REPOSITORY                                                       TAG       IMAGE ID       CREATED       SIZE
601730047828.dkr.ecr.us-east-1.amazonaws.com/ds-lifetime-model   latest    e7b19fd1b455   3 weeks ago   7.73MB
```
