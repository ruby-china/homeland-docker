# NAME:     rubychina/web
# VERSION:  0.0.1

FROM rubychina/base:latest

ENV RAILS_ENV 'production'

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www && cd /var/www &&\
    git clone https://github.com/ruby-china/ruby-china.git &&\
    chown -R ruby:ruby /var/www &&\
    cd ruby-china &&\
    sudo -u ruby bundle install --deployment

WORKDIR /var/www

RUN mkdir -p /var/www/log &&\
    mkdir -p /var/www/pids &&\
    chown -R ruby:ruby /var/www

# = Logrotate
ADD etc/logrotate.conf /etc/logrotate.conf

# = Nginx
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/nginx/ruby-china.conf /etc/nginx/conf.d/ruby-china.conf

# = Link App config
ADD config/*.yml /var/www/ruby-china/config/
ADD config/*.rb /var/www/ruby-china/config/

# = Init Web Application
WORKDIR /var/www/ruby-china

CMD git pull origin master
