#!/usr/bin/env bash
HOSTNAME=www.mobileadmonitor.com
SWAP_SIZE=2G
# SSH, HTTP, TLS, consul...., MongoDB
OPEN_PORTS=22,80,443,8300,8301,8203,8400,8500,27017
PING=true
EXTRAS="nodejs textadept consul mongodb"
NODEJS_VERSION=5.2.0
NODE_ENV=production
CONSUL_VERSION=0.5.2
CONSUL_IS_BOOTSTRAP=false
CONSUL_IS_SERVER=true
CONSUL_ENCRYPTION_KEY= # override in private/config.sh
CONSUL_JOIN=           # override in private/config.sh
MONGODB_DATABASE=UsersDB
MONGODB_ADMIN_PASSWORD= # override in private/config.sh
MONGODB_WWW_PASSWORD=   # override in private/config.sh
