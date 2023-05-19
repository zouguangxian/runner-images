#!/bin/bash -e
################################################################################
##  File:  azcopy.sh
##  Desc:  Installs AzCopy
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install AzCopy10
if [ "$(uname -m)" = "x86_64" ]; then
    download_with_retries "https://aka.ms/downloadazcopy-v10-linux" "/tmp" "azcopy.tar.gz"
else
    download_with_retries "https://aka.ms/downloadazcopy-v10-linux-arm64" "/tmp" "azcopy.tar.gz"
fi

tar xzf /tmp/azcopy.tar.gz --strip-components=1 -C /tmp
mv /tmp/azcopy /usr/local/bin/azcopy
chmod +x /usr/local/bin/azcopy
# Create azcopy 10 alias for backward compatibility
ln -sf /usr/local/bin/azcopy /usr/local/bin/azcopy10

invoke_tests "Tools" "azcopy"