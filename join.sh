#!/bin/bash
LEADER=$(vagrant ssh consul-leader -c "ifdata -pa eth1" 2>/dev/null)
echo "Leader IP: $LEADER"
for FOLDER in servers/* ; do
  MACHINE=${FOLDER##*/}
  echo -n "$MACHINE "
  vagrant ssh "$MACHINE" -c "consul join $LEADER" 2>/dev/null
done
vagrant ssh "consul-leader" -c "consul members" 2>/dev/null
