#!/usr/bin/env sh

# env
echo "export HOMELAND_VERSION=${HOMELAND_VERSION}" >> /etc/profile.d/ruby.sh

# Add deploy user
adduser -G wheel -s /bin/bash -D deploy \
&& echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Give write permissions to multiple users on a folder
addgroup nginx www-data \
&& addgroup deploy www-data \
&& chgrp -R www-data ${GEM_HOME} /var/www \
&& chmod -R g+w ${GEM_HOME} /var/www
