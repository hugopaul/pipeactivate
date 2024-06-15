#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Defina suas variáveis
WORKSPACE_DIR="/opt/workspace"
REPO_URL="https://github.com/hugopaul/apipagamentos.git"
REPO_NAME="apipagamentos"
IMAGE_NAME="hugopaul/apipagamentos"
CONTAINER_NAME="apipagamentos"
PROJECT_TOKEN=${PROJECT_TOKEN_ENV}  # Use a variável de ambiente

echo "######### Entrando no diretório ###########"
cd "$WORKSPACE_DIR"
echo "######### Done ###########"

echo "######### Removendo diretório antigo ###########"
rm -rf "$REPO_NAME"
echo "######### Done ###########"

echo "######### Clonando projeto ###########"
git clone https://${APIPAGAMENTOS_TOKEN_ENV}@github.com/hugopaul/apipagamentos.git
echo "######### Done ###########"

echo "######### Entrando no diretório clonado ###########"
cd "$WORKSPACE_DIR/$REPO_NAME"
echo "######### Done ###########"

echo "######### Buildando Docker ###########"
docker build -t="$IMAGE_NAME" -f Dockerfile .
echo "######### Done ###########"

echo "######### Removendo contêiner antigo ###########"
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    docker rm -f "$CONTAINER_NAME"
fi
echo "######### Done ###########"

echo "######### Rodando Docker ###########"
docker run -d -p 8080:8080 --name "$CONTAINER_NAME" --restart=always "$IMAGE_NAME"
echo "######### Done ###########"

echo "######### Removendo pasta clonada ###########"
rm -rf "$WORKSPACE_DIR/$REPO_NAME"
echo "######### Done ###########"
