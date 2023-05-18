#!/bin/bash -e
################################################################################
##  File:  sqlpackage.sh
##  Desc:  Install SqlPackage CLI to DacFx (https://docs.microsoft.com/sql/tools/sqlpackage/sqlpackage-download#get-sqlpackage-net-core-for-linux)
################################################################################

if [ "$(uname -m)" == "aarch64" ]; then
    exit 0
fi

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/amd64/')
# Install libssl1.1 dependency
if isUbuntu22; then
    download_with_retries "http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.18_$arch.deb" "/tmp"
    dpkg -i /tmp/libssl1.1_1.1.1f-1ubuntu2.18_$arch.deb
fi

# Install SqlPackage
download_with_retries "https://aka.ms/sqlpackage-linux" "." "sqlpackage.zip"

unzip -qq sqlpackage.zip -d /usr/local/sqlpackage
rm -f sqlpackage.zip
chmod +x /usr/local/sqlpackage/sqlpackage
ln -sf /usr/local/sqlpackage/sqlpackage /usr/local/bin

invoke_tests "Tools" "SqlPackage"
