#!/usr/bin/env bash
set -eu
# This script uses the Bash Configuration Management Tool (written by me).
# Its one requirement is that 'include' is in the $PATH.
ln -sf /vagrant/decshell/include /usr/bin/include
. include "apt" "user" "swap" "csf" "file" "tar"
# CD to the script directory
cd $(dirname $(readlink -f "$BASH_SOURCE"))
# Import config variables
. config.sh
# Test that this is working
echo "Hello world" > hello_world.txt

# Initial Setup

## System Updates (http://hardenubuntu.com/initial-setup/system-updates)
apt.upgrade_all >/dev/null
apt.unattended-upgrades.is.enabled
## Create a New User (http://hardenubuntu.com/initial-setup/create-new-user)
user.is.added user
#usermod -a -G sudo node
## Disable root account (http://hardenubuntu.com/initial-setup/disable-root-account/)
## Install Tools (http://hardenubuntu.com/initial-setup/install-tools/)
apt.is.installed unzip
apt.is.installed htop
## Disable Shell Accounts (http://hardenubuntu.com/initial-setup/disable-shell-accounts/)

# Server Setup

## Add swap (http://hardenubuntu.com/server-setup/add-swap)
swap.is.size "$SWAP_SIZE"

csf.is.installed
csf.ports.allowed "$OPEN_PORTS"
csf.ping.set "$PING"
(set -x; csf -r >/dev/null)

# Port forwarding
apt.is.installed rinetd
file.has.line "0.0.0.0 80  127.0.0.1 8080" "0.0.0.0 80  127.0.0.1 8080" /etc/rinetd.conf
file.has.line "0.0.0.0 443 127.0.0.1 4433" "0.0.0.0 443 127.0.0.1 4433" /etc/rinetd.conf

## Install extras
for extra in $EXTRAS; do
  echo "Installing extra: $extra"
  "./extras/$extra/install.sh"
done

# Prove that we finished
echo "Goodbye world" > goodbye_world.txt
