#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export HOMEBREW_NO_INSTALL_UPGRADED=1

brew tap liamg/tfsec -y
brew install sops  \
  awscli \
  helm \
  vim \
  pre-commit \
  gawk \
  coreutils \
  terraform-docs \
  tflint \
  tfsec \
  checkov \
  terragrunt \
  go \
  tfenv \

mkdir $HOME/.terragrunt
mkdir $HOME/.aws
cp /custom-configmaps/runners-terragrunt/* $HOME/.terragrunt
cp /custom-configmaps/runners-aws-profiles/* $HOME/.aws
cp /custom-configmaps/scripts/current-env.sh /home/linuxbrew/.linuxbrew/bin/current-env
cp /custom-configmaps/zsh/.zshrc $HOME/.zshrc