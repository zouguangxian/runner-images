#!/bin/bash -e
################################################################################
##  File:  pulumi.sh
##  Desc:  Installs Pulumi
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/x64/')
# Install Pulumi
VERSION=$(curl --fail --silent -L "https://www.pulumi.com/latest-version")
TARBALL_URL="https://get.pulumi.com/releases/sdk/pulumi-v${VERSION}-linux-$arch.tar.gz"
download_with_retries ${TARBALL_URL} "/tmp" pulumi-v${VERSION}.tar.gz
tar --strip=1 -xf /tmp/pulumi-v${VERSION}.tar.gz -C /usr/local/bin

invoke_tests "Tools" "Pulumi"
