#!/bin/bash

# Defina as variáveis de conexão e ambiente
USER="root"
HOST="45.56.70.78"
PASSWORD="Reisapao123*"
SHEL_FILE="/opt/workspace/pipeactivate/controlefinanceiro-prod.sh"

# Crie um arquivo temporário para armazenar a senha
PASSFILE=$(mktemp)
echo "${PASSWORD}" > "${PASSFILE}"
chmod 400 "${PASSFILE}"

# Execute o comando via SSH, exportando a variável de ambiente
sshpass -f "${PASSFILE}" ssh "${USER}"@"${HOST}" sh "${SHEL_FILE}"

# Exclua o arquivo de senha temporário
rm "${PASSFILE}"

