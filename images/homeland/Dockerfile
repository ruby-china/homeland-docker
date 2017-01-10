# NAME:     homeland/homeland
FROM homeland/base:0.2.3

ENV RAILS_ENV 'production'
ENV HOMELAND_VERSION '2.5.1'

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www &&\
    cd /var/www &&\
    git clone --branch v$HOMELAND_VERSION https://github.com/ruby-china/homeland.git --depth 1
RUN cd /var/www/homeland && bundle install --deployment &&\
    find /var/www/homeland/vendor/bundle -name tmp -type d -exec rm -rf {} + &&\
    chown -R ruby:ruby /var/www

RUN curl https://get.acme.sh | sh

WORKDIR /var/www/homeland
