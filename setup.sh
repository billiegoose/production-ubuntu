#!/usr/bin/env bash
# This script uses the Bash Configuration Management Tool (written by me).
# Its one requirement is that 'include' is in the $PATH.
ln -sf /vagrant/setup/BashCMT/include /usr/bin/include
. include apt
echo "Hello world" > hello_world.txt