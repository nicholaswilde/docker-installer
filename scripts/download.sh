#!/bin/bash

# https://stackoverflow.com/a/246128/1061279
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BIN_DIR="${DIR}/../bin"

# Cleanup the bin dir
rm -rf ${BIN_DIR}
mkdir ${BIN_DIR}

LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/jpillora/installer/releases/latest)

# The releases are returned in the format {"id":3622206,"tag_name":"hello-1.0.0.11",...}, we have to extract the tag_name.
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')

function download_file(){

  VERSION=$(echo ${2} | sed 's/[A-Za-z]*//g')
  echo $VERSION | tee ${DIR}/../VERSION
  FILENAME="installer_${VERSION}_linux_${1}.gz"
  ARTIFACT_URL="https://github.com/jpillora/installer/releases/download/${2}/${FILENAME}"
  BIN_PATH="${DIR}/../bin/${FILENAME}"

  wget -nv ${ARTIFACT_URL} -O ${BIN_PATH}
  gzip -df ${BIN_PATH}
  chmod +x $(echo ${BIN_PATH} | sed -e "s/\.gz//")
}

download_file armv7 $LATEST_VERSION
download_file arm64 $LATEST_VERSION
