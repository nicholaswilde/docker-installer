FROM --platform=$BUILDPLATFORM alpine:3.12.1 as base
ARG TARGETARCH
ARG BUILDPLATFORM
ARG VERSION=0.2.9
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    wget=1.20.3-r1 \
    gzip=1.10-r0

FROM base as base_amd64
ARG VERSION
WORKDIR "/tmp"
RUN \
  echo "**** download installer ****" && \
  wget "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_amd64.gz" && \
  gzip -d /tmp/* && \
  mv installer_${VERSION}_linux_amd64 installer && \
  chmod +x installer

FROM alpine:3.12.1 as build_amd64
COPY --from=base_amd64 /tmp/installer /installer

#########################

FROM base as base_arm64
ARG VERSION
WORKDIR "/tmp"
RUN \
  echo "**** download installer ****" && \
  wget "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_arm64.gz" && \
  gzip -d /tmp/* && \
  mv installer_${VERSION}_linux_arm64 installer && \
  chmod +x installer

FROM alpine:3.12.1 as build_arm64
COPY --from=base_arm64 /tmp/installer /installer

#########################

FROM base as base_arm
ARG VERSION
WORKDIR "/tmp"
RUN \
  echo "**** download installer ****" && \
  wget "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_armv7.gz" && \
  gzip -d /tmp/* && \
  mv installer_${VERSION}_linux_armv7 installer && \
  chmod +x installer

FROM alpine:3.12.1 as build_arm
COPY --from=base_arm /tmp/installer /installer

########################

# hadolint ignore=DL3006
FROM build_${TARGETARCH}
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ca-certificates=20191127-r4 && \
    update-ca-certificates
CMD ["./installer"]
