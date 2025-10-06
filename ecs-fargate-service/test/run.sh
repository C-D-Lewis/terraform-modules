#!/bin/bash

# Healthcheck server
python3 -m http.server 8080 &

# EFS write test
echo "hello world" > /var/data/efs/hello
cat /var/data/efs/hello

# Run for an hour
sleep 3600
