#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ENV_DIR=${DIR}/../.env
PROJECT_DIR=${DIR}/..

TERRAFORM_CONFIG_FILE=${ENV_DIR}/config/terraform.env

# Get Vault envs
source ${ENV_DIR}/config/vault.env

# Remove old file
rm -f ${TERRAFORM_CONFIG_FILE}

# Get credentials
AWS_SECRET_KEY=$(${ENV_DIR}/bin/vault kv get -format=json ${VAULT_KV_PATH}/terraform/ | \
    jq -r '.data.data.aws_secret_key')

AWS_ACCESS_KEY=$(${ENV_DIR}/bin/vault kv get -format=json ${VAULT_KV_PATH}/terraform/ | \
    jq -r '.data.data.aws_access_key')

SSH_KEY_PRIVATE=$(${ENV_DIR}/bin/vault kv get -format=json ${VAULT_KV_PATH}/terraform/ | \
    jq -r '.data.data.rsa_key')

SSH_KEY_PUBLIC=$(${ENV_DIR}/bin/vault kv get -format=json ${VAULT_KV_PATH}/terraform/ | \
    jq -r '.data.data.rsa_key_pub')

# Create config file
mkdir -p ${ENV_DIR}/config
echo "# This file was autogenerated! Don't edit it!" >> ${TERRAFORM_CONFIG_FILE}
echo "TF_VAR_aws_secret_key='${AWS_SECRET_KEY}'" >> ${TERRAFORM_CONFIG_FILE}
echo "TF_VAR_aws_access_key='${AWS_ACCESS_KEY}'" >> ${TERRAFORM_CONFIG_FILE}

# Create OpenSSL key
mkdir -p ${PROJECT_DIR}/terraform/keys
echo "${SSH_KEY_PRIVATE}" > ${PROJECT_DIR}/terraform/keys/id_rsa
echo "${SSH_KEY_PUBLIC}" > ${PROJECT_DIR}/terraform/keys/id_rsa.pub
chmod 600 ${PROJECT_DIR}/terraform/keys/*

# Init Terraform
cd ${PROJECT_DIR}/terraform
${ENV_DIR}/bin/terraform init