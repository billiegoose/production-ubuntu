#!/usr/bin/env bash
HOSTNAME=www.mobileadmonitor.com
SWAP_SIZE=2G
OPEN_PORTS=22,80,443,8300,8301,8203,8400,8500
PING=true
EXTRAS="nodejs textadept consul"
NODEJS_VERSION=5.2.0
CONSUL_VERSION=0.5.2
CONSUL_IS_BOOTSTRAP=false
CONSUL_IS_SERVER=true
# Set these in private/config.sh
CONSUL_ENCRYPTION_KEY=
CONSUL_JOIN=
