# harlequin docker container

source: <https://harlequin.sh/docs/postgres/index>

```shell
docker build . 
docker run -it <container_id> /bin/bash
# in the container
harlequin -a postgres -h 10.0.0.22 -U pguser --password PASSWORD -d bbdb_dev
```
