# NAME:     homeland/base
FROM ubuntu:14.04

ENV RUBY_VERSION "2.3.1"

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN echo "0.0.1" > /VERSION

# == Ubuntu Mirror on 163 for China network
RUN \
    echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y curl

# == Install Packages for Ruby Environments.
RUN curl -sSL https://raw.githubusercontent.com/huacnlee/init.d/4c3e898ddee98a2e66db2f2769ac34d8fa8d898d/install_packages | bash

# Clean apt-get
RUN \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# == Install Ruby
RUN echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
    mkdir /src && cd /src && git clone https://github.com/rbenv/ruby-build.git &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build && ruby-build $RUBY_VERSION /usr/local/
RUN gem install bundler

# == Install Nginx
RUN curl -sSL https://git.io/vVHhf | bash

ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
	BUNDLE_BIN="$GEM_HOME/bin" \
	BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
	&& chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

RUN useradd ruby -s /bin/bash -m -U &&\
    mkdir -p /var/www &&\
    wget -t 10 -q https://github.com/ruby-china/homeland/archive/v$HOMELAND_VERSION.tar.gz &&\
    tar zx v$HOMELAND_VERSION.tar.gz &&\
    mv homeland-$HOMELAND_VERSION/ homeland &&\
    chown -R ruby:ruby /var/www
