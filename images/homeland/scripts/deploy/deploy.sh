#!/usr/bin/env sh

echo [DEBUG]USER      : $(whoami)
echo [DEBUG]WORKDIS   : $(pwd)
echo [DEBUG]PATH      : ${PATH}
echo [DEBUG]CONF_OPTS : ${CONFIGURE_OPTS}

touch .profile && curl https://get.acme.sh | sh

git clone --branch v${HOMELAND_VERSION} https://github.com/ruby-china/homeland.git --depth 1 \
&&  cd homeland \
&&  bundle install --deployment \
&&  find vendor/bundle -name tmp -type d -exec rm -rf {} + \
&&  ln -s ${HOME}/homeland /var/www/homeland
