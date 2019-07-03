#!/bin/bash -x

sudo su

system-docker stop docker

cd /opt && wget https://github.com/rancher/k3s/releases/download/v0.6.1/k3s
chmod +x k3s && ./k3s server –disable-agent &

# cat /var/lib/rancher/k3s/server/node-token
