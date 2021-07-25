FROM ubuntu:focal

LABEL about.license="SPDX:Apache-2.0"

ARG container_user
RUN test -n "${container_user}"

USER root

WORKDIR /tmp

# Enable shell pipefail option
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN adduser --disabled-password ${container_user} \
    && usermod -a -G users ${container_user} \
    && usermod -a -G sudo ${container_user} \
    && echo "${container_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${container_user} \
    && chmod 0440 /etc/sudoers.d/${container_user}

USER ${container_user}

CMD ["/bin/bash","-l"]
