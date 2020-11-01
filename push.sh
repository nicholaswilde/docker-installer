#!/bin/bash

TAG=0.2.7

docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t nicholaswilde/installer:$TAG --push .
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t nicholaswilde/installer:latest --push .
