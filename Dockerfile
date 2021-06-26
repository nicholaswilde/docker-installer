FROM ghcr.io/linuxserver/baseimage-alpine:3.14 as base
ARG VERSION
WORKDIR /tmp
COPY ./checksums.txt .
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    wget=1.21.1-r1 \
    gzip=1.10-r1

FROM base as base_amd64
ARG VERSION
WORKDIR /tmp
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN \
  echo "**** download installer ****" && \
  wget -q "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_amd64.gz" && \
  sha256sum ./installer_${VERSION}_linux_amd64.gz | sha256sum --ignore-missing -c ./checksums.txt || if [ "$?" -eq "141" ]; then true; else exit $?; fi && \
  gzip -d /tmp/installer_${VERSION}_linux_amd64.gz && \
  mv installer_${VERSION}_linux_amd64 installer && \
  chmod +x installer

FROM ghcr.io/linuxserver/baseimage-alpine:3.14 as build_amd64
COPY --from=base_amd64 /tmp/installer /installer

#########################

FROM base as base_arm64
ARG VERSION
WORKDIR /tmp
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN \
  echo "**** download installer ****" && \
  wget -q "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_arm64.gz" && \
  sha256sum ./installer_${VERSION}_linux_arm64.gz | sha256sum --ignore-missing -c ./checksums.txt || if [ "$?" -eq "141" ]; then true; else exit $?; fi && \
  gzip -d /tmp/installer_${VERSION}_linux_arm64.gz && \
  mv installer_${VERSION}_linux_arm64 installer && \
  chmod +x installer

FROM ghcr.io/linuxserver/baseimage-alpine:3.14 as build_arm64
COPY --from=base_arm64 /tmp/installer /installer

#########################

FROM base as base_arm
ARG VERSION
WORKDIR /tmp
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN \
  echo "**** download installer ****" && \
  wget -q "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_armv7.gz" && \
  sha256sum ./installer_${VERSION}_linux_armv7.gz | sha256sum --ignore-missing -c ./checksums.txt || if [ "$?" -eq "141" ]; then true; else exit $?; fi && \
  gzip -d /tmp/installer_${VERSION}_linux_armv7.gz && \
  mv installer_${VERSION}_linux_armv7 installer && \
  chmod +x installer

FROM ghcr.io/linuxserver/baseimage-alpine:3.14 as build_arm
COPY --from=base_arm /tmp/installer /installer

########################

# hadolint ignore=DL3006
FROM build_${TARGETARCH}
ARG VERSION
ARG BUILD_DATE
# hadolint ignore=DL3048
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ca-certificates=20191127-r5 && \
  echo "**** cleanup ****" && \
  rm -rf /tmp/*
CMD ["./installer"]
