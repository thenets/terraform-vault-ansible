ANSIBLE_INVENTORY_FILE=../ansible/hosts.ini

update-ansible-inventory:
	crudini --set config_file terraform my_app $$(terraform output app_public_ip)
	crudini --set config_file terraform my_loadbalancer $$(terraform output loadbalancer_public_ip)

ssh-app:
	ssh -i key/id_rsa ubuntu@$$(terraform output app_public_ip)

ssh-loadbalancer:
	ssh -i key/id_rsa ubuntu@$$(terraform output loadbalancer_public_ip)
