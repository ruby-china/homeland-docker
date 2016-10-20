# NAME:     homeland/web
# VERSION:  0.0.1

FROM homeland/base:latest

ENV RAILS_ENV 'production'
ENV BUNDLE_PATH '/var/cache/bundle'
VOLUME ["/var/cache/bundle"]


MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www && cd /var/www &&\
    git clone https://github.com/ruby-china/ruby-china.git --depth 1 homeland &&\
    chown -R ruby:ruby /var/www &&\
    cd homeland &&\
    git checkout 8ec3112 -q &&\
    sudo -u ruby bundle install --deployment

WORKDIR /var/www

RUN mkdir -p /var/www/log &&\
    mkdir -p /var/www/pids &&\
    chown -R ruby:ruby /var/www

# = Link App config
COPY config/*.yml /var/www/homeland/config/
COPY config/*.rb /var/www/homeland/config/

# = Init Web Application
WORKDIR /var/www/homeland
