FROM --platform=$BUILDPLATFORM alpine:3.12.1 as build
ARG TARGETARCH
ARG BUILDPLATFORM
ARG PLATFORM
RUN apk --update upgrade && \
    apk add curl ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*
WORKDIR '/app'

FROM build as build_arm
ONBUILD COPY ./bin/installer_0.2.7_linux_armv7 /app/installer

FROM build as build_arm64
ONBUILD COPY ./bin/installer_0.2.7_linux_arm64 /app/installer

FROM build_${TARGETARCH}
CMD ["./installer"]
