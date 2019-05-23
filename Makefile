#!make

##
# Import settings
## 
include config
export $(shell sed 's/=.*//' config)


##
# Variables
# (don't change it)
##
ENV_DIR=./.env
PY_ENV_DIR=$(ENV_DIR)/python_env


##
# Main commands
##
prepare:
#-- Fix permissions
	chmod +x ./scripts/*

#-- Install dependencies
	sudo apt-get update -qq
	sudo apt-get install -qq -y curl wget zip unzip jq python3 virtualenv crudini

	make create-python-virtualenv
	make install-terraform
	make install-vault
	make install-aws-cli
	make install-ansible

#-- Fix permissions
	chmod +x $(ENV_DIR)/bin/*

#-- Setup
	make setup-all-force

	@echo "$$helloMsg"


##
# Installers
##
create-python-virtualenv:
	virtualenv -p python3 $(PY_ENV_DIR)

install-terraform:
	mkdir -p $(ENV_DIR)/bin
	wget -O $(ENV_DIR)/bin/terraform.zip https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_linux_amd64.zip
	cd $(ENV_DIR)/bin && unzip -o ./terraform.zip
	rm $(ENV_DIR)/bin/terraform.zip
	chmod +x $(ENV_DIR)/bin/terraform
	@echo "\n# Hashicorp Terraform installed!\n"

install-vault:
	mkdir -p $(ENV_DIR)/bin
	wget -O $(ENV_DIR)/bin/vault.zip https://releases.hashicorp.com/vault/$(VAULT_VERSION)/vault_$(VAULT_VERSION)_linux_amd64.zip
	cd $(ENV_DIR)/bin && unzip -o ./vault.zip
	rm $(ENV_DIR)/bin/vault.zip
	chmod +x $(ENV_DIR)/bin/vault
	@echo "\n# Hashicorp Vault installed!\n"

install-aws-cli:
	. $(PY_ENV_DIR)/bin/activate && \
		pip3 install awscli --upgrade

install-ansible:
	. $(PY_ENV_DIR)/bin/activate && \
		pip install ansible --upgrade


##
# Helpers
##
setup-all-force:
	rm -f $(ENV_DIR)/config/*.env
	make setup-vault
	make setup-terraform

setup-vault:
	VAULT_ADDR=$(VAULT_ADDR) \
	VAULT_TOKEN=$(VAULT_TOKEN) \
		scripts/setup-vault.sh

setup-terraform:
	VAULT_ADDR=$(VAULT_ADDR) \
	VAULT_KV_PATH=$(VAULT_KV_PATH) \
		scripts/setup-terraform.sh

define helloMsg

|￣￣￣￣￣￣￣￣￣￣￣￣￣￣|
 OI, $(shell getent passwd "$(shell id -u)" | cut -d: -f1 | tr a-z A-Z)!
 O AMBIENTE ESTÁ PRONTO.
 DIVIRTA-SE!
|＿＿＿＿＿＿＿＿＿＿＿＿＿＿| 
  (\__/) ||
  (•ㅅ•) ||
  / 　  づ
endef
export helloMsg
# hello:
# 	@echo "$$helloMsg"
