# docker-installer
A Docker image for [jpillora's](https://github.com/jpillora) [installer](https://github.com/jpillora/installer) web server.

## Requirements
- [buildx](https://docs.docker.com/engine/reference/commandline/buildx/)

## Usage
```bash
$ docker run -d \
  --name=installer \
  -e USER=username `#optional` \
  -e GH_TOKEN=token `#optional` \
  -e PORT=port `#optional` \
  -p 3000:3000 \
  --restart unless-stopped \
  nicholaswilde/installer
``` 
