#!/bin/bash

SSH_DIR="/home/slave/.ssh/"
AUTHORIZED_KEY_FILE="$SSH_DIR/authorized_keys"

if [ -n "$AUTHORIZED_KEY" ]; then
    echo "key: $AUTHORIZED_KEY"
    mkdir -p $SSH_DIR
    echo "ssh-rsa $AUTHORIZED_KEY" > $AUTHORIZED_KEY_FILE
    echo "" >> $AUTHORIZED_KEY_FILE
else
    echo "No AUTHORIZED_KEY found. You can mount /home/slave/.ssh/authorized_keys instead."
fi

cat $AUTHORIZED_KEY_FILE

# start ssh server 
/usr/sbin/sshd -D