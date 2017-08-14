# NAME:     homeland/base
FROM alpine:3.6
MAINTAINER Jason Lee "https://github.com/huacnlee"

ARG RUBY_VERSION=${RUBY_VERSION:-2.4.0}

ENV CONFIGURE_OPTS="ac_cv_func_isnan=yes ac_cv_func_isinf=yes --disable-install-doc" \
    NOKOGIRI_USE_SYSTEM_LIBRARIES=1 \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    RUBY_VERSION=${RUBY_VERSION} \
    RUBY_BUILD_MIRROR_URL=https://cache.ruby-china.org \
    GEM_HOME=/usr/local/bundle

ENV BUNDLE_PATH=${GEM_HOME} \
    BUNDLE_BIN=${GEM_HOME}/bin \
    BUNDLE_APP_CONFIG=${GEM_HOME}

ENV PATH $BUNDLE_BIN:$PATH

COPY scripts/*.sh /tmp/
RUN  ls /tmp/*.sh | sh && rm -rf /tmp/*.sh

# Define default command.
CMD ["/bin/bash", "--login"]
