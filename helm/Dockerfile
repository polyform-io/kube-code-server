FROM codercom/code-server:latest

COPY ./setup.sh ./setup.sh


RUN sudo apt install curl -y
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

RUN export HOMEBREW_NO_INSTALL_UPGRADED=1

RUN brew tap liamg/tfsec -y
RUN brew install sops
RUN brew install  awscli
RUN brew install  helm
RUN brew install  vim
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
