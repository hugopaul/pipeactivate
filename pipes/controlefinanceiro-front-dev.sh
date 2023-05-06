#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/
echo "######### done ###########"
echo "######### entrando diretorio clonado ###########"

cd controlefinanceiro-front
echo "######### done ###########"
echo "######### trocando de branch  ###########"

git checkout develop
echo "######### done ###########"
echo "######### fazendo pull ###########"

git pull
echo "######### done ###########"
echo "#########  npm install ###########"

npm install

echo "######### done ###########"
echo "######### buildando projeto ###########"

ng build --configuration=dev --base-href=/controle-dev/

echo "######### done ###########"
echo "######### buildando docker ###########"

docker build -f Dockerfile-dev  -t=hugopaul/controlefinanceiro-front-dev .

echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-front-dev" -f

echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 100:80 --name  controlefinanceiro-front-dev  hugopaul/controlefinanceiro-front-dev
echo "######### done ###########"
