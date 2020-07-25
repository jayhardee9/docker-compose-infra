#!/bin/bash

# Truncate or create authorized_keys config for deploy user
echo > /etc/ssh/authorized_keys/deploy

for app in "$@"
do
  # Only allow deploy user (using key generated for <app>) to run a deploy-<app>.sh script
  echo "command=\"./deploy-${app}.sh\",no-port-forwarding,no-x11-forwarding,no-agent-forwarding `cat /home/deploy/.ssh/${app}.id_ed25519.pub`" >> /etc/ssh/authorized_keys/deploy
done
