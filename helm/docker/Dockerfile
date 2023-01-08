# syntax=docker/dockerfile:experimental

ARG BASE=debian:11
FROM scratch AS packages
FROM $BASE

RUN apt-get update \
  && apt-get install -y \
    curl \
    dumb-init \
    zsh \
    htop \
    locales \
    man \
    nano \
    git \
    git-lfs \
    procps \
    openssh-client \
    sudo \
    vim.tiny \
    lsb-release \
  && git lfs install \
  && rm -rf /var/lib/apt/lists/*

RUN sudo apt install curl -y
RUN curl -L https://github.com/coder/code-server/releases/download/v4.9.1/code-server_4.9.1_amd64.deb -o /tmp/code-server_4.9.1_amd64.deb

RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

RUN brew install sops
RUN brew install  awscli
RUN brew install  helm
RUN brew install  pre-commit
RUN brew install  gawk
RUN brew install  coreutils
RUN brew install  terraform-docs
RUN brew install  tflint
RUN brew install  tfsec
RUN brew install  checkov
RUN brew install  terragrunt
RUN brew install  go
RUN brew install  tfenv

RUN sudo mkdir /docker-build-temp/
RUN curl https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce-cli_20.10.8~3-0~debian-buster_amd64.deb --output /docker-build-temp/docker.deb
RUN sudo dpkg -i /docker-build-temp/docker.deb
RUN sudo rm -rf /docker-build-temp/
# https://wiki.debian.org/Locale#Manually
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
  && locale-gen
ENV LANG=en_US.UTF-8

RUN adduser --gecos '' --disabled-password coder \
  && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN ARCH="$(dpkg --print-architecture)" \
  && curl -fsSL "https://github.com/boxboat/fixuid/releases/download/v0.5/fixuid-0.5-linux-$ARCH.tar.gz" | tar -C /usr/local/bin -xzf - \
  && chown root:root /usr/local/bin/fixuid \
  && chmod 4755 /usr/local/bin/fixuid \
  && mkdir -p /etc/fixuid \
  && printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN --mount=from=packages,src=/tmp,dst=/tmp/packages dpkg -i /tmp/packages/code-server*$(dpkg --print-architecture).deb

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN sudo chsh -s $(which zsh)

RUN brew cleanup
RUN sudo apt-get clean
# Allow users to have scripts run on container startup to prepare workspace.
# https://github.com/coder/code-server/issues/5177
ENV ENTRYPOINTD=${HOME}/entrypoint.d

EXPOSE 8080
# This way, if someone sets $DOCKER_USER, docker-exec will still work as
# the uid will remain the same. note: only relevant if -u isn't passed to
# docker-run.
USER 1000
ENV USER=coder
WORKDIR /home/coder
ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
