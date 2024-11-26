#!/bin/bash
set -eux


source ./vars.sh

SWARM_WORKER_IP_LIST=$(cat $(find $ROOT_FOLDER/env_ip/*private_ip.txt))

# initialize swarm cluster
$SSH_DOCKER_MACHINE 'docker swarm init --advertise-addr '$LEADER_DOCKER_MACHINE_IP

export JOIN_TOKEN_WORKER=$($SSH_DOCKER_MACHINE docker swarm join-token worker -q | cat -v | sed 's/\^M//g')
export JOIN_TOKEN_MANAGER=$(ssh -tt -o "StrictHostKeyChecking=no" -i $PATH_TO_KEY $USER@$DOCKER_MACHINE_IP docker swarm join-token manager -q | cat -v | sed 's/\^M//g')

#configure master node for docker remote managment
 $SSH_DOCKER_MACHINE 'sudo mkdir -p /etc/systemd/system/docker.service.d && \
  sudo touch /etc/systemd/system/docker.service.d/options.conf &&\
  sudo chmod 777 /etc/systemd/system/docker.service.d/options.conf && \
  sudo echo [Service] > /etc/systemd/system/docker.service.d/options.conf && \
  sudo echo ExecStart= >> /etc/systemd/system/docker.service.d/options.conf && \
  sudo echo ExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:'$DOCKER_MANAGMENT_PORT' >> /etc/systemd/system/docker.service.d/options.conf && \
  sudo systemctl daemon-reload && \
  sudo systemctl restart docker'

#join workers to leader
for i in $SWARM_WORKER_IP_LIST
  do
    $SSH_DOCKER_MACHINE "ssh -tt -o "StrictHostKeyChecking=no" -i $PATH_TO_PRIVATE_KEY $USER@$i docker swarm join --token $JOIN_TOKEN_WORKER $LEADER_DOCKER_MACHINE_IP:2377" &
  done
