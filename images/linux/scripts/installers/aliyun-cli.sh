#!/bin/bash -e
################################################################################
##  File:  aliyun-cli.sh
##  Desc:  Installs Alibaba Cloud CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/amd64/')
# Install Alibaba Cloud CLI
downloadUrl="https://aliyuncli.alicdn.com/aliyun-cli-linux-latest-$arch.tgz"
download_with_retries $downloadUrl "/tmp"
tar xzf /tmp/aliyun-cli-linux-*-$arch.tgz
mv aliyun /usr/local/bin

invoke_tests "CLI.Tools" "Aliyun CLI"
