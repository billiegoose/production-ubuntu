#!/usr/bin/env bash
. include "apt" "file"
. config.sh
. private/config.sh

function mongodb.assert.user() {
  local USER="$1"
  local PWD="$2"
  local DB="$3"
  local ROLE="$4"
  mongo --username "$USER" --password "$PWD" --eval 'version()' "$DB" &>/dev/null <<SCRIPT
var user = db.getUser("${USER}");
if ( user.roles.length  != 1
  || user.roles[0].role != "$ROLE"
  || user.roles[0].db   != "$DB") {
  throw new Error("role mismatch");
}
SCRIPT
}

function mongodb._create_user() {
  local USER="$1"
  local PWD="$2"
  local DB="$3"
  local ROLE="$4"
(set -x; mongo "$DB" >/dev/null <<SCRIPT
db.createUser(
  {
    user: "$USER",
    pwd: "$PWD",
    roles: [ { role: "$ROLE", db: "$DB" } ]
  }
)
SCRIPT
)
}

function mongodb._update_user() {
  local USER="$1"
  local PWD="$2"
  local DB="$3"
  local ROLE="$4"
(set -x; mongo "$DB" <<SCRIPT
db.updateUser( "$USER",
  {
    pwd: "$PWD",
    roles: [ { role: "$ROLE", db: "$DB" } ]
  }
)
SCRIPT
)
}

function mongodb.has.user() {
  local USER="$1"
  local PWD="$2"
  local DB="$3"
  local ROLE="$4"
  if ! mongodb.assert.user "$USER" "$PWD" "$DB" "$ROLE"; then
    echo "bad user"
    if ! mongodb._update_user "$USER" "$PWD" "$DB" "$ROLE"; then
      echo "bad update"
      if ! mongodb._create_user "$USER" "$PWD" "$DB" "$ROLE"; then
        echo "bad create"
        return 1
      fi
    fi
  fi
  mongodb.assert.user "$USER" "$PWD" "$DB" "$ROLE"
}

function mongodb.install() {
  local BIND_IP="$1"
  local DB_NAME="$2"
  local ADMIN_PWD="$3"
  local USER_PWD="$4"
  file.has.contents "/etc/apt/sources.list.d/mongodb-org-3.2.list" \
    <<<'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse'
  apt.has.key EA312927
  apt.is.installed mongodb-org

  # Note: This could potentially disrupt existing connections, but the downtime
  # is very brief.
  if ! mongodb.assert.user 'admin' "$ADMIN_PWD" 'admin' 'userAdminAnyDatabase' ||
     ! mongodb.assert.user 'www' "$USER_PWD" "$DB_NAME" 'readWrite'; then
    # Stop MongoDB
    service mongod stop
    # Disable logins from other than localhost
    file.has.line "\bbindIp\b" "net.bindIp: localhost" /etc/mongod.conf
    # Disable authentication
    file.has.line "\bsecurity.authorization\b" "security.authorization: disabled" /etc/mongod.conf
    # Restart MongoDB
    service mongod start
    # Pause to let mongo finish starting
    sleep 2 # 1 sec was sufficient in testing. Doubled here for factor-of-safety.

    # Create admin user
    mongodb.has.user "admin" "$ADMIN_PWD" "admin"    userAdminAnyDatabase
    mongodb.has.user "www"   "$USER_PWD"  "$DB_NAME" readWrite
  fi
  # Allow logins from other than localhost
  file.has.line "\bbindIp\b" "net.bindIp: $BIND_IP" /etc/mongod.conf
  # Activate authentication
  file.has.line "\bsecurity.authorization\b" "security.authorization: enabled" /etc/mongod.conf
  # Restart mongo
  (set -x; service mongod restart)

  # TODO: Move this somewhere, I dunno
  file.has.contents "/etc/consul.d/mongo.json" <<CONTENTS
{ "service":
  { "name": "mongo"
  , "port": 27017
  }
}
CONTENTS
  (set -x; consul reload)
}

mongodb.install "$MONGODB_BIND" "$MONGODB_DATABASE" "$MONGODB_ADMIN_PASSWORD" "$MONGODB_WWW_PASSWORD"
