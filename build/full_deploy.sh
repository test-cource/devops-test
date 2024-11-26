#!/bin/bash
set -eux

#script expects AWS access and secret keys in arguments
#
# detect path to folders with scripts and terraform
SCRIPTS_FOLDER_PATH=$(pwd)
TERRAFORM_FOLDER_NAME=terraform
TERRAFORM_FOLDER_PATH="${SCRIPTS_FOLDER_PATH}/../"
ROOT_FOLDER="${SCRIPTS_FOLDER_PATH}/results"
LOG_FOLDER_PATH="${ROOT_FOLDER}/logs"


#get AWS access and secret keys
export TF_VAR_AWS_ACCESS_KEY=$1
export TF_VAR_AWS_SECRET_KEY=$2


mkdir -p $ROOT_FOLDER
# deploy PoP
mkdir -p $ROOT_FOLDER/logs
cd $TERRAFORM_FOLDER_PATH
$TERRAFORM_FOLDER_PATH/terraform init  | tee -a $LOG_FOLDER_PATH/terraform-init.log
$TERRAFORM_FOLDER_PATH/terraform plan  | tee -a $LOG_FOLDER_PATH/terraform-plan.log
$TERRAFORM_FOLDER_PATH/terraform apply -auto-approve | tee -a $LOG_FOLDER_PATH/terraform-deploy.log

#create folder for keys
mkdir -p $ROOT_FOLDER/keys

#print key to file
$TERRAFORM_FOLDER_PATH/terraform output key_pair > $ROOT_FOLDER/keys/ssh_key.pem

#create folder for ip addresses
mkdir -p $ROOT_FOLDER/env_ip


#print Nginx public IP to file
$TERRAFORM_FOLDER_PATH/terraform output docker_machine_public_ip_addresses > $ROOT_FOLDER/env_ip/docker_machine_public_ip.txt

#print Nginx private IP to file
$TERRAFORM_FOLDER_PATH/terraform output docker_machine_private_ip_addresses > $ROOT_FOLDER/env_ip/docker_machine_private_ip.txt

#print php-fpm public IP to file
#$TERRAFORM_FOLDER_PATH/terraform output casandra_public_ip_addresses | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > $ROOT_FOLDER/env_ip/casandra_public_ip.txt

#print php-fpm private IP to file
$TERRAFORM_FOLDER_PATH/terraform output casandra_private_ip_addresses > $ROOT_FOLDER/env_ip/casandra_private_ip.txt

