#!/bin/bash

# Healthcheck server
python3 -m http.server 80 &

# EFS write test
echo "hello world" > /var/data/efs/hello
cat /var/data/efs/hello

sleep 600
