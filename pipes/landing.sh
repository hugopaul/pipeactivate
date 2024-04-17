#!/bin/bash

# Defina o diretório do projeto
PROJECT_DIR="/opt/workspace/landing-lowyer"

echo "######### Verificando se o diretório do projeto existe ###########"
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Diretório $PROJECT_DIR não existe, clonando o projeto..."
    git clone https://github.com/hugopaul/landing-lowyer.git "$PROJECT_DIR"
else
    echo "Diretório já existe. Entrando no diretório e atualizando o projeto..."
    cd "$PROJECT_DIR"

    echo "######### Atualizando o projeto ###########"
    git checkout main
    git pull origin main --rebase
fi

echo "######### Construindo o Docker com Buildx ###########"
docker buildx build --load -f Dockerfile -t hugopaul/landing-page .

echo "######### Removendo o contêiner antigo, se existir ###########"
docker rm "landing-page" -f || true

echo "######### Rodando o contêiner do Docker ###########"
docker run -d -p 101:80 --name landing-page hugopaul/landing-page

echo "######### Processo concluído com sucesso ###########"