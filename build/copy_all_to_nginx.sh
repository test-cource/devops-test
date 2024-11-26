#!/bin/bash
set -eux


# detect path to folders with scripts and terraform
SCRIPTS_FOLDER_PATH=$(pwd)
TERRAFORM_FOLDER_NAME=terraform
TERRAFORM_FOLDER_PATH="${SCRIPTS_FOLDER_PATH}/../"
ROOT_FOLDER="${SCRIPTS_FOLDER_PATH}/results"
LOG_FOLDER_PATH="${ROOT_FOLDER}/logs"
USER="ec2-user"


#get controller ip as variable
DOCKER_MACHINE_IP=$(cat "$ROOT_FOLDER/env_ip/docker_machine_public_ip.txt")

#change permission for keys
#chmod 600 $ROOT_FOLDER/keys/ssh_key.pem

#create folder for copying files
ssh -t -o "StrictHostKeyChecking=no" -i $ROOT_FOLDER/keys/ssh_key.pem $USER@$DOCKER_MACHINE_IP 'mkdir -p ~/minds'

#copy aws folder to controller's aws folder
scp -r -o "StrictHostKeyChecking=no" -i $ROOT_FOLDER/keys/ssh_key.pem $ROOT_FOLDER/keys/ $USER@$DOCKER_MACHINE_IP:~/minds/keys/
scp -r -o "StrictHostKeyChecking=no" -i $ROOT_FOLDER/keys/ssh_key.pem $SCRIPTS_FOLDER_PATH $USER@$DOCKER_MACHINE_IP:~/minds/

#set permission to cert file
ssh -t -o "StrictHostKeyChecking=no" -i $ROOT_FOLDER/keys/ssh_key.pem $USER@$DOCKER_MACHINE_IP 'chmod 0600 ~/minds/keys/ssh_key.pem'
ssh -t -o "StrictHostKeyChecking=no" -i $ROOT_FOLDER/keys/ssh_key.pem $USER@$DOCKER_MACHINE_IP 'chmod +x ~/minds/build/*.sh'
#ssh -t -o "StrictHostKeyChecking=no" -i ../keys/ssh_key.pem admin@$NGINX_IP 'chmod +x ~/minds/scripts/zoo/*.sh'
