FROM nimlang/nim:1.4.6-alpine

ENV PATH $PATH:/root/.nimble/bin
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        curl \
        gcc \
        musl-dev \
        bsd-compat-headers \
        openssl \
        pcre \
        sqlite

WORKDIR /root/project
