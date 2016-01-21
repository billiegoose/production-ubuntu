#!/usr/bin/env bash
. config
. private/config.sh
apt.is.installed libkrb5-dev
apt.is.installed build-essential
apt.is.installed git
# Install private repo
if [[ -z "$GITHUB_USER" -a -z "$GITHUB_REPO" -a -z "$GITHUB_TOKEN" ]] ; then
  sudu -iu user github.download "$GITHUB_USER" "$GITHUB_REPO" "$GITHUB_TOKEN" /home/user
  sudo -lu user npm install
fi
