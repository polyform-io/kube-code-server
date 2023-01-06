#!/usr/bin/env bash
#    && apt install YOUR_PACKAGE \
#    && rm -rf /var/lib/apt/lists/* \

TERRAGRUNT_VERSION=0.42.4
TFENV_VERSION=3.0.0

sudo apt-get update && apt-get install -y \
    amazon-ecr-credential-helper \
    unzip \
    wget \
    python3-pip


mkdir temp

cd /tmp && \
    git clone --depth 1 --branch v${TFENV_VERSION} https://github.com/tfutils/tfenv.git /home/${USERNAME}/.tf&& \
    ln -s /home/${USERNAME}/.tfenv/bin/* /usr/local/bin && \
    tfinstall 1.3.6

wget "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64" && \
    chmod +x terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
tflint --version
rm -rf temp

curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

pip3 install pre-commit

terragrunt-env.sh /usr/local/bin/current-env
chmod +x /usr/local/bin/current-env

