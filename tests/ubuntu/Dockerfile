# The main ubuntu image is so fucking large, DO NOT DO THAT AT HOME! Instead, we'll writing this Dockerfile
# based on https://github.com/gitpod-io/workspace-images/blob/master/base/Dockerfile, minus all the BS we don't
# really need in an real machine.
FROM buildpack-deps:focal

# Start our way out as root first
USER root

# Reserved if you building from source
ARG DOCKER_UID=1000

# Copy our scripts to their destinations
COPY ../common/bin/logger.sh /usr/bin/entrypoint.sh
COPY ./bin/install-packages /usr/bin/install-packages

# Install deps in noninteractive mode.
ARG DEBIAN_FRONTEND=noninteractive

RUN yes | unminimize \
    && install-packages \
        zip \
        unzip \
        bash-completion \
        build-essential \
        ninja-build \
        htop \
        jq \
        less \
        locales \
        man-db \
        nano \
        ripgrep \
        software-properties-common \
        sudo \
        time \
        multitail \
        lsof \
        ssl-cert \
        zsh \
    && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8

### Git ###
RUN add-apt-repository -y ppa:git-core/ppa \
    && install-packages git git-lfs

### Our dummy UNIX user, in which case, we're gonna use my usual Ubuntu user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN useradd -l -u $DOCKER_UID -G sudo -md /home/gildedguy -s /bin/bash -p gildedguy gildedguy \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

### Our dummy UNIX user, in which case, we're gonna use my usual Ubuntu user (2) ###
USER gildedguy

# use sudo so that we don't get sudo usage info on (the first) login
# also I misspelled Gildedguy's name for memes lol
RUN sudo echo "Running 'sudo' for Guildedguy: success"

# configure git-lfs
RUN sudo git lfs install --system
