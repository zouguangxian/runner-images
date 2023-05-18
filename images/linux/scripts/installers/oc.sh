#!/bin/bash -e
################################################################################
##  File:  oc.sh
##  Desc:  Installs the OC CLI
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install the oc CLI
suffix=$(if [ "$(uname -m)" == "aarch64" ]; then echo "-arm64"; fi)
DOWNLOAD_URL="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux${suffix}.tar.gz"

PACKAGE_TAR_NAME="oc.tar.gz"
download_with_retries $DOWNLOAD_URL "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin" oc

invoke_tests "CLI.Tools" "OC CLI"