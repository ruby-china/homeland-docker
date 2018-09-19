# NAME:     homeland/base
FROM ubuntu:14.04

MAINTAINER Jason Lee "https://github.com/huacnlee"

RUN apt-get update && apt-get install -y curl

# == Install Packages for Ruby Environments.
RUN curl -sSL https://raw.githubusercontent.com/huacnlee/init.d/4951e9f61c500eb7ec8ec2a2cffa352b81fc05b9/install_packages | bash

# Clean apt-get
RUN \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://get.acme.sh | sh

# == Install Ruby
ENV RUBY_VERSION "2.5.1"
ENV RUBY_BUILD_MIRROR_URL "https://cache.ruby-china.com"
RUN echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
    mkdir /src && cd /src && git clone https://github.com/rbenv/ruby-build.git --depth 1 &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build &&\
    ruby-build $RUBY_VERSION /usr/local/
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

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
