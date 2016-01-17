#!/usr/bin/env bash
set -eu
# This script uses the Bash Configuration Management Tool (written by me).
. include "file" "tar"
. config.sh

function install_nodejs() {
  local VERSION="$1"
  ## Install nodejs
  if ! which node >/dev/null || [[ $(node -v) != "v$VERSION" ]]; then
    file.is.downloaded "https://nodejs.org/dist/v${VERSION}/node-v${VERSION}-linux-x64.tar.xz" /tmp/node.tar.xz
    tar.is.extracted '/tmp/node.tar.xz' /opt
    (set -x; ln -s "/opt/node-v${VERSION}-linux-x64/bin/node" /usr/local/bin/node)
    (set -x; ln -s "/opt/node-v${VERSION}-linux-x64/bin/npm" /usr/local/bin/npm)
  fi
}
install_nodejs "$NODEJS_VERSION"
