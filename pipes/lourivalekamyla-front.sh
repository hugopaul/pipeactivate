#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Defina suas variáveis
WORKSPACE_DIR="/opt/workspace"
REPO_NAME="lourivalekamyla-front"
IMAGE_NAME="hugopaul/lourivalekamyla-front"
CONTAINER_NAME="lourivalekamyla-front"

echo "######### Entrando no diretório ###########"
cd "$WORKSPACE_DIR/$REPO_NAME"
echo "######### Done ###########"

echo "######### Dando reset e pull na branch ###########"
git reset --hard
git checkout main
git fetch
git pull origin main --rebase
echo "######### Done ###########"

echo "######### Buildando Docker ###########"
docker build -f Dockerfile -t="$IMAGE_NAME" .
echo "######### Done ###########"

echo "######### Removendo contêiner antigo ###########"
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    docker rm -f "$CONTAINER_NAME"
fi
echo "######### Done ###########"

echo "######### Rodando Docker ###########"
docker run -d -p 5000:80 --restart=always --name "$CONTAINER_NAME" "$IMAGE_NAME"
echo "######### Done ###########"
