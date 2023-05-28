#!/bin/bash -e
################################################################################
##  File:  heroku.sh
##  Desc:  Installs Heroku CLI
################################################################################

if [ "$(uname -m)" == "aarch64" ]; then
    exit 0
fi

# Install Heroku CLI
curl https://cli-assets.heroku.com/install.sh | sh

invoke_tests "Tools" "Heroku"