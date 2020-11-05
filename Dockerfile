FROM --platform=$BUILDPLATFORM alpine:3.12.1 as base
ARG TARGETARCH
ARG BUILDPLATFORM
ARG VERSION=0.2.7
RUN \
  echo "**** install packages ****" && \
  apk --update upgrade && \
  apk add --no-cache \
    wget \
    gzip

from base as base_arm64
ARG VERSION
WORKDIR "/tmp"
RUN \
  echo "**** download installer ****" && \
  wget "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_arm64.gz" && \
  gzip -d /tmp/* && mv installer_${VERSION}_linux_arm64 installer && chmod +x installer

FROM alpine as build_arm64
COPY --from=base_arm64 /tmp/installer /installer

from base as base_arm
ARG VERSION
WORKDIR "/tmp"
RUN \
  echo "**** download installer ****" && \
  wget "https://github.com/jpillora/installer/releases/download/v${VERSION}/installer_${VERSION}_linux_armv7.gz" && \
  gzip -d /tmp/* && mv installer_${VERSION}_linux_armv7 installer && chmod +x installer

FROM alpine as build_arm
COPY --from=base_arm /tmp/installer /installer

FROM build_${TARGETARCH}
RUN \
  echo "**** install packages ****" && \
  apk --update upgrade && \
  apk add --no-cache \
    ca-certificates && \
    update-ca-certificates
CMD /installer
