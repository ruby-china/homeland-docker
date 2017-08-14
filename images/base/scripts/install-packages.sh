#!/usr/bin/env sh
# https://raw.githubusercontent.com/huacnlee/init.d/4c3e898ddee98a2e66db2f2769ac34d8fa8d898d/install_packages
# Basic Commands
apk add --update --no-cache --virtual .tools \
    bash \
    busybox-suid \
    ca-certificates \
    curl \
    git \
    htop \
    libressl \
    openssh-client \
    sudo \
    tar \
    tzdata \
    vim \
&&  rm -rf /var/cache/apk/*
# OK: 67 MiB in 23 packages

# Build Requirements
apk add --update --no-cache --virtual .build-deps \
    build-base \
    libc-dev \
    libevent-dev \
    libgcc \
    libressl-dev \
    libstdc++ \
    linux-headers \
    pcre-dev \
    readline-dev \
    yaml-dev \
    zlib-dev \
&&  rm -rf /var/cache/apk/*
# OK: 219 MiB in 36 packages

# Rails Requirements
apk add --update --no-cache --virtual .ruby-deps \
    libffi-dev \
    libgcrypt-dev \
    libxslt-dev \
    libxml2-dev \
&&  rm -rf /var/cache/apk/*
# OK: 4 MiB in 9 packages

# GEM Requirements
apk add --update-cache --no-cache --virtual .gems-deps  \
    curl-dev \
    hiredis-dev \
    imagemagick \
    imagemagick-dev \
    postgresql-dev \
&&  rm -rf /var/cache/apk/*
# OK: 81 MiB in 31 packages

# Node.js
apk add --update --no-cache --virtual .nodejs \
    libsass \
    nodejs-current \
    nodejs-current-npm \
    sassc \
&&  rm -rf /var/cache/apk/*
# OK: 40 MiB in 8 packages

# nginx
# https://raw.githubusercontent.com/huacnlee/init.d/master/install_nginx
apk add --update --no-cache --virtual .nginx \
    nginx \
    nginx-mod-http-geoip \
    nginx-mod-http-image-filter \
&&  rm -rf /var/cache/apk/*
# OK: 2 MiB in 5 packages

# OK: 413 MiB in 128 packages
