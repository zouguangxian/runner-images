#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Get the latest Stack version..."
stackDownloadUrl=$(get_github_package_download_url "commercialhaskell/stack" "contains(\"osx-x86_64.tar.gz\")" "latest" "$API_PAT")
stackVersion=$(echo $stackDownloadUrl | cut -d "/" -f8 | tr -d "v")
stackArchive="/tmp/stack.tar.gz"

echo "Download stack version $stackVersion..."
download_with_retries $stackDownloadUrl "/tmp" "stack.tar.gz"

arch=$(uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/x64/')
stackToolcachePath="$AGENT_TOOLSDIRECTORY/stack/$stackVersion"
destinationPath="$stackToolcachePath/$arch"

mkdir -p $destinationPath

echo "Unzip stack archive..."
tar -xzf $stackArchive -C $destinationPath --strip 1

touch $stackToolcachePath/$arch.complete

echo "export PATH="\$PATH":$destinationPath" >> "$HOME/.bashrc"

invoke_tests "Common" "Stack"
