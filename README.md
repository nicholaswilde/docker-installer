# installer
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/installer)](https://hub.docker.com/r/nicholaswilde/installer)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/installer)](https://hub.docker.com/r/nicholaswilde/installer)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-installer)](./LICENSE)
[![YAML Lint](https://github.com/nicholaswilde/docker-installer/workflows/YAML%20Lint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-installer/actions?query=workflow%3A%22YAML+Lint%22)

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
