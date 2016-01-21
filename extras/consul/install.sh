#!/usr/bin/env bash
set -e
. include "file" "zip" "dir" "symlink" "user" "apt"
. config.sh
. private/config.sh

install_consul() {
  local VERSION="$1"
  file.is.downloaded "https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip" "/tmp/consul_${VERSION}_linux_amd64.zip"
  dir.is.present /opt/consul
  zip.is.extracted "/tmp/consul_${VERSION}_linux_amd64.zip" /opt/consul
  symlink.is.present /usr/local/bin/consul /opt/consul/consul
  user.is.added "consul"
  dir.is.present /var/consul
  file.has.owner "consul:consul" /var/consul
  # TODO: Open ports 8300 8301 8203 8400 8500
  apt.is.installed "dnsmasq"
  file.has.contents /etc/consul.json <<CONTENT
{
  "bootstrap": $CONSUL_IS_BOOTSTRAP,
  "server": $CONSUL_IS_SERVER,
  "datacenter": "nyc3",
  "data_dir": "/var/consul",
  "encrypt": "$CONSUL_ENCRYPTION_KEY",
  "log_level": "INFO",
  "enable_syslog": true,
  "start_join": [ $CONSUL_JOIN ]
}
CONTENT

  file.has.contents /etc/init/consul.conf <<CONTENT
description "Consul server process"
start on (local-filesystems and net-device-up IFACE=eth0)
stop on runlevel [!12345]
respawn
setuid consul
setgid consul
exec consul agent --config-file /etc/consul.json --config-dir /etc/consul.d
CONTENT

  file.has.contents /etc/dnsmasq.d/10-consul <<<"server=/consul/127.0.0.1#8600"
}
install_consul "$CONSUL_VERSION"
