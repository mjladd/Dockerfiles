# LFO-dockerfiles

## saws

#### Description

Alpine-based container to run SAWS (AWS CLI). 

Info: https://github.com/donnemartin/saws

Req: setup a folder for storing AWS credentials. 

Source : https://aws.amazon.com/blogs/security/a-new-and-standardized-way-to-manage-credentials-in-the-aws-sdks/
Source : http://docs.aws.amazon.com/cli/latest/topic/config-vars.html

```shell
mkdir ~/.aws
touch ~/.aws/config

[default]
aws_access_key_id = ACCESS KEY HERE
aws_secret_access_key = SECRET KEY HERE
```

### Build and run a container
```shell
docker build -t lfo:saws .
docker run -it -v $CREDS_DIR:/root/.aws:ro lfo:saws
```
