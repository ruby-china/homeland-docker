# NAME:     homeland/web
# VERSION:  0.0.1

FROM homeland/base:latest

MAINTAINER Jason Lee "https://github.com/huacnlee"

VOLUME ["/usr/local/bundle"]

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www && cd /var/www &&\
    git clone https://github.com/ruby-china/ruby-china.git --depth 1 homeland &&\
    chown -R ruby:ruby /var/www

WORKDIR /var/www

RUN mkdir -p /var/www/log &&\
    mkdir -p /var/www/pids &&\
    mkdir -p /var/www/.bundle &&\
    chown -R ruby:ruby /var/www

VOLUME ["/usr/local/bundle"]

# = Nginx
COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/homeland.conf /etc/nginx/conf.d/homeland.conf

USER ruby
WORKDIR /var/www
RUN git clone https://github.com/ruby-china/ruby-china.git --depth 50 homeland &&\
    cd homeland &&\
    mkdir -p /var/www/homeland/tmp/cache &&\
    git checkout 8167fe7 -q &&\
    bundle install --jobs 2 --retry=3

# = Link App config
COPY config/*.yml /var/www/homeland/config/
COPY config/*.rb /var/www/homeland/config/

# = Init Web Application
WORKDIR /var/www/homeland
USER root
