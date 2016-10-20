# NAME:     rubychina/web
# VERSION:  0.0.1

FROM rubychina/base:latest

ENV RAILS_ENV 'production'

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www && cd /var/www &&\
    git clone https://github.com/ruby-china/ruby-china.git --depth 1 homeland &&\
    chown -R ruby:ruby /var/www &&\
    cd homeland &&\
    git checkout 8ec3112 &&\
    sudo -u ruby bundle install --deployment

WORKDIR /var/www

RUN mkdir -p /var/www/log &&\
    mkdir -p /var/www/pids &&\
    chown -R ruby:ruby /var/www

# = Logrotate
COPY etc/logrotate.conf /etc/logrotate.conf

# = Nginx
COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/homeland.conf /etc/nginx/conf.d/homeland.conf

# = Link App config
COPY config/*.yml /var/www/homeland/config/
COPY config/*.rb /var/www/homeland/config/

# = Init Web Application
WORKDIR /var/www/homeland
