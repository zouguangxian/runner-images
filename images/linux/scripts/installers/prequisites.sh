#!/bin/sh
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates sudo lsb-release wget curl unzip vim.tiny walinuxagent motd-news-config python3 python3-pip python3-dev icu-devtools 

# Install powershell
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libicu-dev
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.3.4/powershell-7.3.4-linux-$(uname -m | sed -e 's/x86_64/x64/g' -e 's/aarch64/arm64/g').tar.gz
mkdir -p /opt/microsoft/powershell/7
tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
chmod +x /opt/microsoft/powershell/7/pwsh
ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
