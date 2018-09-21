# NAME:     homeland/base
FROM ruby:2.5-alpine

MAINTAINER Jason Lee "https://github.com/huacnlee"
RUN gem install bundler
RUN apk --update add ca-certificates nodejs tzdata imagemagick &&\
    apk add --virtual .builddeps build-base ruby-dev libc-dev openssl linux-headers postgresql-dev \
    libxml2-dev libxslt-dev git curl nginx nginx-mod-http-image-filter nginx-mod-http-geoip &&\
    rm /etc/nginx/conf.d/default.conf

RUN curl https://get.acme.sh | sh

