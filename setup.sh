#!/usr/bin/env bash
set -eu
# This script uses the Bash Configuration Management Tool (written by me).
# Its one requirement is that 'include' is in the $PATH.
ln -sf /vagrant/setup/BashCMT/include /usr/bin/include
. include apt user
echo "Hello world" > hello_world.txt
#
# Initial Setup::System Updates (http://hardenubuntu.com/initial-setup/system-updates)
#
# To make sure this base image is up to date, update all the packages and remove old version
apt.upgrade_all
# Turn on unattended upgrades
apt.unattended-upgrades.is.enabled
#
# Initial Setup::System Updates (http://hardenubuntu.com/initial-setup/create-new-user)
#
user.is.added node
sudo usermod -a -G sudo node
