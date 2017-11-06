# NAME:     homeland/homeland
FROM homeland/base:0.2.3
MAINTAINER Jason Lee "https://github.com/huacnlee"

ENV RAILS_ENV 'production'
RUN curl https://get.acme.sh | sh

ENV HOMELAND_VERSION '3.0.10'

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www &&\
    cd /var/www &&\
    git clone --branch v$HOMELAND_VERSION https://github.com/ruby-china/homeland.git --depth 1
RUN rm -rf /var/www/homeland/vendor/bundle &&\
    cd /var/www/homeland && bundle install --deployment &&\
    find /var/www/homeland/vendor/bundle -name tmp -type d -exec rm -rf {} + &&\
    chown -R ruby:ruby /var/www

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /var/www/homeland
