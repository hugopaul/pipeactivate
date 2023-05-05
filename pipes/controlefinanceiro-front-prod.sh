#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/controlefinanceiro-front
echo "######### done ###########"
echo "######### trocando de branch  ###########"

git checkout prod
echo "######### done ###########"
echo "######### fazendo pull ###########"

git pull
echo "######### done ###########"
echo "#########  npm install ###########"

npm install

echo "######### done ###########"
echo "######### buildando projeto ###########"

ng build --configuration=prod

echo "######### done ###########"
echo "######### buildando docker ###########"

docker build -f Dockerfile-prod  -t=hugopaul/controlefinanceiro-front-prod .

echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-front-prod" -f

echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 82:80 --name  controlefinanceiro-front-prod  hugopaul/controlefinanceiro-front-prod
echo "######### done ###########"
