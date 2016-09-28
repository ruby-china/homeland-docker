# NAME:     rubychina/web
# VERSION:  0.0.1

FROM rubychina/base:0.0.1

ENV RAILS_ENV 'production'

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www && cd /var/www &&\
    git clone https://github.com/ruby-china/ruby-china.git &&\
    chown -R ruby:ruby /var/www &&\
    cd ruby-china &&\
    sudo -u ruby bundle install --deployment

WORKDIR /var/www

RUN mkdir -p /data/redis &&\

RUN mkdir -p /var/www/log &&\
    mkdir -p /var/www/pids &&\
    chown -R ruby:ruby /var/www