#!/bin/bash -e
################################################################################
##  File:  terraform.sh
##  Desc:  Installs terraform
################################################################################

source $HELPER_SCRIPTS/install.sh

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/amd64/')
# Install Terraform
URL=$(curl -s https://api.releases.hashicorp.com/v1/releases/terraform/latest | jq --arg arch $arch -r '.builds[] | select((.arch==$arch) and (.os=="linux")).url')
ZIP_NAME="terraform_linux_$arch.zip"
download_with_retries "${URL}" "/tmp" "${ZIP_NAME}"
unzip -qq "/tmp/${ZIP_NAME}" -d /usr/local/bin
rm -f "/tmp/${ZIP_NAME}"

invoke_tests "Tools" "Terraform"