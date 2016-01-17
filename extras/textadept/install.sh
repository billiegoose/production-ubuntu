#!/usr/bin/env bash
set -eu
# This script uses the Bash Configuration Management Tool (written by me).
. include "file" "tar"

function install_textadept() {
  if ! which ta >/dev/null; then
    file.is.downloaded "http://foicica.com/textadept/download/textadept_LATEST.x86_64.tgz" /tmp/textadept.tgz
    tar.is.extracted '/tmp/textadept.tgz' /opt
    (set -x; ln -sf /opt/textadept_*/textadeptjit-curses /usr/local/bin/ta)
  fi
}
install_textadept
