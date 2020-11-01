FROM alpine:3.12.1
RUN apk --update upgrade && \
    apk add curl ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*
COPY ./installer /home/
CMD /home/installer
