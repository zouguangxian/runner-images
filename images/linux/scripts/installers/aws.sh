#!/bin/bash -e
################################################################################
##  File:  aws.sh
##  Desc:  Installs the AWS CLI, Session Manager plugin for the AWS CLI, and AWS SAM CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

download_with_retries "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" "/tmp" "awscliv2.zip"
unzip -qq /tmp/awscliv2.zip -d /tmp
/tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/64bit/')
download_with_retries "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_$arch/session-manager-plugin.deb" "/tmp" "session-manager-plugin.deb"
apt install /tmp/session-manager-plugin.deb

# Download & install the latest aws sam cli release
case $(uname -m) in
    x86_64)
    zipName="aws-sam-cli-linux-$(uname -m).zip"
    zipUrl="https://github.com/aws/aws-sam-cli/releases/latest/download/${zipName}"
    download_with_retries $zipUrl "/tmp" $zipName
    unzip /tmp/${zipName} -d /tmp
    /tmp/install
        ;;
    aarch64)
        pip install aws-sam-cli       
        ;;
esac

invoke_tests "CLI.Tools" "AWS"
