#!/bin/sh
set -eux

#this script installs docker engine from https://get.docker.com

#apt update and install curl
apt update
apt install -y curl

#download and run docker installation script
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt install -y docker-compose

#add admin user to docker group
usermod -aG docker ubuntu
