FROM debian:stable-slim

LABEL about.license="SPDX:Apache-2.0"

ARG container_user
RUN test -n "${container_user}"

USER root

WORKDIR /tmp

# Enable shell pipefail option
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -qq -y && apt-get install --no-install-recommends -qq -y \
	      curl \
        gnupg2 \
        apt-transport-https \
        ca-certificates \
        git \
        python3 python3-pip \
        tini \
    && update-ca-certificates \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password ${container_user} \
    && usermod -a -G users ${container_user}

USER ${container_user}

# lichess.token and calibration.bin are manually generated via scripts in `certabo-lichess`
WORKDIR /tmp/certabo-lichess
RUN git clone https://github.com/${container_user}/certabo-lichess.git . \
    && python3 -m pip install --user -r requirements.txt \
    && touch lichess.token \
    && mkdir -p /home/${container_user}/.local/share

ENTRYPOINT ["tini", "--"]

# /dev/certabo is a bind mount defined in docker-compose.yaml
CMD /tmp/certabo-lichess/certabo-lichess.py --correspondence --port /dev/certabo
