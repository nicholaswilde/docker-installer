# Docker Installer
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/installer)](https://hub.docker.com/r/nicholaswilde/installer)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/installer)](https://hub.docker.com/r/nicholaswilde/installer)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-installer)](./LICENSE)
[![hadolint](https://github.com/nicholaswilde/docker-installer/workflows/hadolint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-installer/actions?query=workflow%3Ahadolint)
[![yamllint](https://github.com/nicholaswilde/docker-installer/workflows/yamllint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-installer/actions?query=workflow%3Ayamllint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fnicholaswilde%2Fdocker-installer.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fnicholaswilde%2Fdocker-installer?ref=badge_shield)

A Docker image for [jpillora's](https://github.com/jpillora) [installer](https://github.com/jpillora/installer) web server.

## Dependencies

* None

## Usage

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

### docker-compose

See [docker-compose.yaml](./docker-compose.yaml).

## Development

See [docs](https://nicholaswilde.io/docker-docs/development).

## Troubleshooting

See [docs](https://nicholaswilde.io/docker-docs/troubleshooting).

## Pre-commit hook

If you want to automatically generate `README.md` files with a pre-commit hook, make sure you
[install the pre-commit binary](https://pre-commit.com/#install), and add a [.pre-commit-config.yaml file](./.pre-commit-config.yaml)
to your project. Then run:

```bash
pre-commit install
pre-commit install-hooks
```
Currently, this only works on `arm64` systems.

## License

[Apache 2.0 License](./LICENSE)

## Author
This project was started in 2020 by [Nicholas Wilde](https://github.com/nicholaswilde/).
