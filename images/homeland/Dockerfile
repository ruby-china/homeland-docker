# NAME:     homeland/homeland
FROM homeland/base:1.0.0
MAINTAINER Jason Lee "https://github.com/huacnlee"

ENV RAILS_ENV 'production'

ENV HOMELAND_VERSION '3.0.11'

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www &&\
    cd /var/www &&\
    git clone --branch v$HOMELAND_VERSION https://github.com/ruby-china/homeland.git --depth 1
RUN cd /var/www/homeland && bundle install --deployment &&\
    find /var/www/homeland/vendor/bundle -name tmp -type d -exec rm -rf {} + &&\
    chown -R ruby:ruby /var/www

WORKDIR /var/www/homeland
