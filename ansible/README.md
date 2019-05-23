# ansible

## Inventário

No arquivo de inventário `./inventory.conf` estão todos os servidores que são gerenciados pelo Ansible.

## Baixar ou atualizar dependências

Existem roles que são baixadas do Ansible Galaxy (https://galaxy.ansible.com/) e, portanto, eles precisarão ser baixadas antes de serem utilizadas. Para baixá-las ou atualizá-las, execute o comando:

```bash
ansible-galaxy install -r requirements.yml
```

Este comando instalará todas as dependências definidas no `requirements.yml`.
