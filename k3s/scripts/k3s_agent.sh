#!/bin/bash -x

sudo su

system-docker stop docker

cd /opt && wget https://github.com/rancher/k3s/releases/download/v0.6.1/k3s
chmod +x k3s

# ./k3s agent -s https://server-ip:6443 --token ${node_token} &
