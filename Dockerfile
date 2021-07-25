FROM ubuntu:focal

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
    && usermod -a -G users ${container_user} \
    && usermod -a -G sudo ${container_user} \
    && echo "${container_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${container_user} \
    && chmod 0440 /etc/sudoers.d/${container_user}

USER ${container_user}

RUN git clone https://github.com/${container_user}/certabo-lichess.git \
    && cd certabo-lichess \
    && python3 -m pip install --user -r requirements.txt

ENTRYPOINT ["tini", "--"]

CMD /home/${container_user}/certabo-lichess/certabo-lichess.py --correspondence
