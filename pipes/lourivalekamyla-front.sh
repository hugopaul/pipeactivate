#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Defina suas variáveis
WORKSPACE_DIR="/opt/workspace"
REPO_NAME="lourivalekamyla-front"
IMAGE_NAME="hugopaul/lourivalekamyla-front"
CONTAINER_NAME="lourivalekamyla-front"
PROJECT_TOKEN=${PROJECT_TOKEN_ENV}  # Use a variável de ambiente

# Verifica se PROJECT_TOKEN está definido
if [ -z "$PROJECT_TOKEN" ]; then
  echo "Error: PROJECT_TOKEN não está definido."
  exit 1
fi

echo "######### Removendo diretório antigo ###########"
cd "$WORKSPACE_DIR"
rm -rf "$REPO_NAME"
echo "######### Done ###########"

echo "######### Clonando projeto ###########"
git clone https://${PROJECT_TOKEN}:x-oauth-basic@github.com/hugopaul/$REPO_NAME.git
echo "######### Done ###########"

echo "######### Entrando no diretório ###########"
cd "$WORKSPACE_DIR"/"$REPO_NAME"
echo "######### Done ###########"

echo "######### Buildando imagem Docker ###########"
docker build -f Dockerfile -t="$IMAGE_NAME" .
echo "######### Done ###########"

echo "######### Removendo contêiner antigo ###########"
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    docker rm -f "$CONTAINER_NAME"
fi
echo "######### Done ###########"

echo "######### Rodando contêiner Docker ###########"
docker run -d -p 5000:80 --restart=always --name "$CONTAINER_NAME" "$IMAGE_NAME"
echo "######### Done ###########"
