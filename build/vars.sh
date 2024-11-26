#!/bin/bash
set -eu

#script contains all variables
#
export USER="ec2-user"

# detect path to folders with scripts and terraform
export SCRIPTS_FOLDER_PATH=$(pwd)
export CONTAINERS_PATH="${SCRIPTS_FOLDER_PATH}/../../minds/containers/"
export ENGINE_PATH="${SCRIPTS_FOLDER_PATH}/../../minds/engine"
export FRONT_PATH="${SCRIPTS_FOLDER_PATH}/../../minds/front"
export TERRAFORM_FOLDER_NAME=terraform
export TERRAFORM_FOLDER_PATH="${SCRIPTS_FOLDER_PATH}/../"
export ROOT_FOLDER="${SCRIPTS_FOLDER_PATH}/results"
export LOG_FOLDER_PATH="${ROOT_FOLDER}/logs"

#IP for SWARM
export DOCKER_MACHINE_IP=$(cat "$ROOT_FOLDER/env_ip/docker_machine_public_ip.txt")
export LEADER_DOCKER_MACINE_IP=$(cat "$ROOT_FOLDER/env_ip/docker_machine_private_ip.txt")
export CASANDRA_IP=$(cat "$ROOT_FOLDER/env_ip/casandra_public_ip.txt")

#docker remote managment port
export DOCKER_MANAGMENT_PORT=2375

#path to scipt folder
export SCRIPT_PATH=/home/admin/minds/build

#path to private keys
export PATH_TO_KEY=$ROOT_FOLDER/keys/ssh_key.pem

#path to private keys
export PATH_TO_PRIVATE_KEY=/home/admin/minds/build/results/keys/ssh_key.pem

#ssh to DOCKER_MACHINE
export SSH_DOCKER_MACHINE="ssh -tt -o "StrictHostKeyChecking=no" -i $PATH_TO_KEY $USER@$DOCKER_MACHINE_IP"
