#!/usr/bin/env sh

cd /root \
&& git clone https://github.com/rbenv/ruby-build.git --depth 1 \
&& ruby-build/install.sh

if which ruby-build >/dev/null; then
  # Clear src and build ruby.
  rm -rf ruby-build \
  && ruby-build ${RUBY_VERSION} /usr/local/

  # Install Bundler
  if which gem >/dev/null; then
    mkdir /usr/local/etc \
    &&    echo 'gem: --no-document' > /usr/local/etc/gemrc \
    &&    gem update --system \
    &&    gem install bundler

    if which bundle >/dev/null; then
      bundle config --global silence_root_warning 1 \
      &&     bundle config --global build.nokogiri --use-system-libraries \
      >      /dev/null

cat > /etc/profile.d/ruby.sh <<EOF
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export CONFIGURE_OPTS=${CONFIGURE_OPTS}
export NOKOGIRI_USE_SYSTEM_LIBRARIES=${NOKOGIRI_USE_SYSTEM_LIBRARIES}
export BUNDLE_SILENCE_ROOT_WARNING=${BUNDLE_SILENCE_ROOT_WARNING}
export RUBY_BUILD_MIRROR_URL=${RUBY_BUILD_MIRROR_URL}
export RUBY_VERSION=${RUBY_VERSION}
export GEM_HOME=${GEM_HOME}
export BUNDLE_PATH=\${GEM_HOME}
export BUNDLE_BIN=\${GEM_HOME}/bin
export BUNDLE_APP_CONFIG=\${GEM_HOME}
export PATH=\${BUNDLE_BIN}:\${PATH}

ulimit -c unlimited

EOF
    fi
  fi
fi
