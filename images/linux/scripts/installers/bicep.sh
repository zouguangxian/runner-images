#!/bin/bash -e
################################################################################
##  File:  bicep.sh
##  Desc:  Installs bicep cli
################################################################################

source $HELPER_SCRIPTS/install.sh

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/x64/')
# Install Bicep CLI
download_with_retries "https://github.com/Azure/bicep/releases/latest/download/bicep-linux-$arch" "." "bicep.bin"
# Mark it as executable
chmod +x ./bicep.bin
# Add bicep to PATH (requires admin)
sudo mv ./bicep.bin /usr/local/bin/bicep

invoke_tests "Tools" "Bicep"