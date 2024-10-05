#!/bin/bash

# Defina o diretório do projeto
PROJECT_DIR="/opt/workspace/lourivalekamyla-front"

# Use a variável de ambiente PROJECT_TOKEN_ENV, ou exiba um erro se não estiver definida
if [ -z "$PROJECT_TOKEN_ENV" ]; then
    echo "Erro: A variável de ambiente PROJECT_TOKEN_ENV não está definida."
    exit 1
fi

PROJECT_TOKEN=${PROJECT_TOKEN_ENV}

echo "######### Verificando se o diretório do projeto existe ###########"
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Diretório $PROJECT_DIR não existe, clonando o projeto..."
    git clone https://${PROJECT_TOKEN}:x-oauth-basic@github.com/hugopaul/lourivalekamyla-front.git "$PROJECT_DIR"
else
    echo "Diretório já existe. Entrando no diretório e atualizando o projeto..."
    cd "$PROJECT_DIR" || { echo "Falha ao entrar no diretório $PROJECT_DIR"; exit 1; }

    echo "######### Atualizando o projeto ###########"
    git checkout main
    git pull origin main --rebase
fi

echo "######### Construindo o Docker ###########"
docker build -f Dockerfile -t hugopaul/lourivalekamyla-front .

echo "######### Removendo o contêiner antigo, se existir ###########"
docker rm -f "lourivalekamyla-front" || true

echo "######### Rodando o contêiner do Docker ###########"
docker run -d -p 5000:80 --name lourivalekamyla-front --restart=always hugopaul/lourivalekamyla-front

echo "######### Processo concluído com sucesso ###########"
