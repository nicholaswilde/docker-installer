#!/bin/bash

# https://stackoverflow.com/a/246128/1061279
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -f $DIR/../VERSION  ]; then
  echo "Missing VERSION file"
fi

TAG=$(<$DIR/../VERSION)

docker buildx build --platform linux/arm/v7,linux/arm64 --build-arg tag=${TAG} -t nicholaswilde/installer:$TAG --push .
docker buildx build --platform linux/arm/v7,linux/arm64 --build-arg tag=${TAG} -t nicholaswilde/installer:latest --push .
