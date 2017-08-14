# NAME:     homeland/homeland
FROM homeland/base:0.2.3
MAINTAINER Jason Lee "https://github.com/huacnlee"

ARG HOMELAND_VERSION=${HOMELAND_VERSION:-3.0.7}
ARG RAILS_ENV=${RAILS_ENV:-production}

ENV RAILS_ENV=${RAILS_ENV} \
    HOMELAND_VERSION=${HOMELAND_VERSION}

COPY scripts/*.sh /tmp/
RUN  ls /tmp/*.sh | sh && rm -rf /tmp/*.sh

USER deploy
WORKDIR /home/deploy

# By user.
COPY scripts/deploy/*.sh /tmp/
RUN  ls /tmp/*.sh | sh && sudo rm -rf /tmp/*.sh

# Define default command.
CMD ["/bin/bash", "--login"]
