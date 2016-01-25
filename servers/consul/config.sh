#!/usr/bin/env bash
HOSTNAME=consul.mobileadmonitor.com
SWAP_SIZE=2G
# SSH, DNS, HTTP, TLS, Consul (Server RPC, SerfLan, SerfWan, CLI RPC, HTTP API)
OPEN_PORTS=22,53,80,443,8300,8301,8302,8400,8500
PING=true
EXTRAS="textadept consul"
CONSUL_VERSION=0.5.2
CONSUL_NODE_NAME=leader
CONSUL_BOOTSTRAP_EXPECT=3
CONSUL_IS_SERVER=true
CONSUL_ENCRYPTION_KEY= # override in private/config.sh
