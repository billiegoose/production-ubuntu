#!/usr/bin/env bash
set -eu
# This script uses the Bash Configuration Management Tool (written by me).
. include "apt" "user" "swap" "csf" "file" "tar"

function install_nodejs() {
  local VERSION="$1"
  ## Install nodejs
  if ! which node ; then
    file.is.downloaded "https://nodejs.org/dist/v${VERSION}/node-v${VERSION}-linux-x64.tar.xz" /tmp/node.tar.xz
    tar.is.extracted '/tmp/node.tar.xz' /opt
    ln -s "/opt/node-v${VERSION}-linux-x64/bin/node" /usr/bin/node
    ln -s "/opt/node-v${VERSION}-linux-x64/bin/npm" /usr/bin/npm
  fi
}
