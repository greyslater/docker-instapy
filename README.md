# docker-instapy
Run InstaPy on Docker with persistent DB and LOG folders

## Usage

```
docker create --name=instapy \
-v <path to data>:InstaPy/persistent \
-v /etc/localtime:/etc/localtime:ro \
greyslater/instapy:latest
```
