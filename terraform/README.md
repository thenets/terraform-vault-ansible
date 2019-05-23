# terraform

Todos os servidores gerenciados pelo Terraform estão definidos aqui.

## Preparar máquina local para trabalhar com o Terraform

Um script automatizado permite instalar o Terraform e preparar a máquina local para utilizar o Terraform.

Após finalizar a instalação do Terraform, será criado o arquivo de credenciais.
Este arquivo será baixado do Hashicorp Vault (é necessário o Token de acesso do Vault).

```bash
make prepare
```
