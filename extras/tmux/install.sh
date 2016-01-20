#!/usr/bin/env bash
. include file tar apt
. config.sh
. private/config.sh

if ! which tmux || [[ "$(tmux -V)" != "tmux $TMUX_VERSION" ]]; then
  apt.is.installed 'libevent-dev'
  apt.is.installed 'libncurses5-dev'
  file.is.downloaded "https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz" /tmp/tmux.tar.gz
  tar.is.extracted /tmp/tmux.tar.gz /tmp
  cd "/tmp/tmux-$TMUX_VERSION"
  ./configure
  make
  make install
fi
