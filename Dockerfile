# NAME:     homeland/web
# VERSION:  0.0.1

FROM homeland/base:latest

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www &&\
    mkdir -p /var/www/.bundle &&\
    chown -R ruby:ruby /var/www

VOLUME ["/var/www/.bundle"]

# = Nginx
COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/homeland.conf /etc/nginx/conf.d/homeland.conf

USER ruby
ENV BUNDLE_JOBS=2 BUNDLE_PATH=/var/www/.bundle

WORKDIR /var/www
RUN git clone https://github.com/ruby-china/ruby-china.git --depth 1 homeland &&\
    cd homeland &&\
    mkdir -p /var/www/homeland/tmp/cache &&\
    git checkout eb51912 -q &&\
    bundle install --deployment --path=/var/www/.bundle --retry=3

VOLUME ['/var/www/homeland/tmp/cache']

# = Link App config
COPY config/*.yml /var/www/homeland/config/
COPY config/*.rb /var/www/homeland/config/

# = Init Web Application
WORKDIR /var/www/homeland
