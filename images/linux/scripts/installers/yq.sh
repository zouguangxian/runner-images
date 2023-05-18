#!/bin/bash -e
################################################################################
##  File:  yq.sh
##  Desc:  Installs YQ
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/amd64/')
YQ_URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_$arch"
download_with_retries "$YQ_URL" "/usr/bin" "yq"
chmod +x /usr/bin/yq

invoke_tests "Tools" "yq"
