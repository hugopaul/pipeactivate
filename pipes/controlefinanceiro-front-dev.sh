#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/
echo "######### done ###########"
echo "######### removendo diretorio ###########"

rm -rf controlefinanceiro-front
echo "######### done ###########"
echo "######### clonando projeto ###########"

git clone https://github.com/hugopaul/controlefinanceiro-front.git
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

npm install -g

echo "######### done ###########"
echo "######### buildando projeto ###########"

ng build --configuration=dev

echo "######### done ###########"
echo "######### buildando docker ###########"

docker build -t=hugopaul/controlefinanceiro-front-dev -f Dockerfile-dev .

echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-front-dev" -f

echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 81:81 --name  controlefinanceiro-front-dev  hugopaul/controlefinanceiro-front-dev
echo "######### done ###########"
echo "######### removendo pasta ###########"

rm -rf controlefinanceiro-front/
echo "######### done ###########"
