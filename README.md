# installer
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/installer)](https://hub.docker.com/r/nicholaswilde/installer)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/installer)](https://hub.docker.com/r/nicholaswilde/installer)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-installer)](./LICENSE)
[![hadolint](https://github.com/nicholaswilde/docker-installer/workflows/hadolint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-installer/actions?query=workflow%3Ahadolint)
[![yamllint](https://github.com/nicholaswilde/docker-installer/workflows/yamllint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-installer/actions?query=workflow%3Ayamllint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fnicholaswilde%2Fdocker-installer.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fnicholaswilde%2Fdocker-installer?ref=badge_shield)

A Docker image for [jpillora's](https://github.com/jpillora) [installer](https://github.com/jpillora/installer) web server.

## Requirements
- [buildx](https://docs.docker.com/engine/reference/commandline/buildx/)

## Usage
### docker-compose
```
---
version: "2.1"
services:
  installer:
    image: nicholaswilde/installer
    container_name: installer
    environment:
      - USER=username   #optional
      - GH_TOKEN=token  #optional
      - PORT=3000       #optional
    ports:
      - 3000:3000
    restart: unless-stopped
```
### docker cli
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

## Build

Check that you can build the following:
```bash
$ docker buildx ls
NAME/NODE    DRIVER/ENDPOINT             STATUS  PLATFORMS
mybuilder *  docker-container                    
  mybuilder0 unix:///var/run/docker.sock running linux/amd64, linux/arm64, linux/arm/v7
```

If you are having trouble building arm images on a x86 machine, see [this blog post](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/).

```
$ make build
```
