#!/bin/bash
set -eux

#script expects AWS access and secret keys in arguments

# detect path to folders with scripts and terraform
SCRIPTS_FOLDER_PATH=$(pwd)
TERRAFORM_FOLDER_NAME=terraform
TERRAFORM_FOLDER_PATH="${SCRIPTS_FOLDER_PATH}/../"
ROOT_FOLDER="${SCRIPTS_FOLDER_PATH}/../scripts/"
LOG_FOLDER_PATH="${ROOT_FOLDER}/../scripts/logs"

#get AWS access and secret keys
export TF_VAR_AWS_ACCESS_KEY=$1
export TF_VAR_AWS_SECRET_KEY=$2

# destroy PoP
mkdir -p $ROOT_FOLDER/logs
cd $TERRAFORM_FOLDER_PATH
$TERRAFORM_FOLDER_PATH/terraform destroy -auto-approve | tee -a $LOG_FOLDER_PATH/terraform-destroy.log
