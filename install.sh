#!/usr/bin/env bash
. include apt symlink
apt.is.installed libkrb5-dev
apt.is.installed build-essential
apt.is.installed git
# Install private repo
if [[ -n "$GITHUB_USER" ]] && [[ -n "$GITHUB_REPO" ]] && [[ -n "$GITHUB_TOKEN" ]] ; then
  sudo -iu user <<SCRIPT
    . include github
    GITHUB_TOKEN=$GITHUB_TOKEN github.download "$GITHUB_USER" "$GITHUB_REPO" develop /home/user
    npm install
SCRIPT
fi
symlink.is.present /home/user/bin/service /etc/init.d/www
