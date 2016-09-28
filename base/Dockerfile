# NAME:     rubychina/base
# VERSION:  0.0.1

FROM ubuntu:14.04

ENV RUBY_VERSION "2.3.1"

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN echo "0.0.1" > /VERSION

# == Ubuntu Mirror on 163 for China network
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y curl

# == Install Packages for Ruby Environments.
RUN curl -sSL https://raw.githubusercontent.com/huacnlee/init.d/4c3e898ddee98a2e66db2f2769ac34d8fa8d898d/install_packages | bash

# == Install Nginx
RUN curl -sSL https://git.io/vVHhf | bash

# == Install PostgreSQL
RUN curl http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" | \
    tee /etc/apt/sources.list.d/postgres.list
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib postgresql-client

# == Install Redis & Memcached
RUN apt-get install -y redis-server memcached

# == Install ElasticSearch
RUN curl -sSL https://git.io/vVHhm | bash

# == Install Ruby
RUN echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
    mkdir /src && cd /src && git clone https://github.com/rbenv/ruby-build.git &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build && ruby-build $RUBY_VERSION /usr/local/
RUN gem install bundler