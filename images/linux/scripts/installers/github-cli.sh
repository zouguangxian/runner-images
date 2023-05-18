#!/bin/bash -e
################################################################################
##  File:  github-cli.sh
##  Desc:  Installs GitHub CLI
##         Must be run as non-root user after homebrew
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/amd64/')
# Install GitHub CLI
downloadUrl=$(get_github_package_download_url "cli/cli" "contains(\"linux\") and contains(\"$arch\") and contains(\".deb\")")
download_with_retries $downloadUrl "/tmp"
apt install /tmp/gh_*_linux_$arch.deb

invoke_tests "CLI.Tools" "GitHub CLI"
