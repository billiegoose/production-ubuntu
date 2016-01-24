#!/usr/bin/env bash
HOSTNAME=mongo.mobileadmonitor.com
SWAP_SIZE=2G
# SSH, DNS, HTTP, TLS, Consul (Server RPC, SerfLan, SerfWan, CLI RPC, HTTP API), MongoDB
OPEN_PORTS=22,53,80,443,8300,8301,8302,8400,8500,27017
PING=true
EXTRAS="textadept consul mongodb"

CONSUL_VERSION=0.5.2
CONSUL_NODE_NAME=mongo
CONSUL_IS_BOOTSTRAP=true
CONSUL_IS_SERVER=true
CONSUL_ENCRYPTION_KEY= # override in private/config.sh
CONSUL_JOIN=           # override in private/config.sh

MONGODB_DATABASE=UsersDB
MONGODB_ADMIN_PASSWORD= # override in private/config.sh
MONGODB_WWW_PASSWORD=   # override in private/config.sh
