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

docker build -t=hugopaul/controlefinanceiro-prod-dev -f Dockerfile-dev .

echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-front-prod" -f

echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 82:82 --name  controlefinanceiro-front-prod  hugopaul/controlefinanceiro-front-prod
echo "######### done ###########"
echo "######### removendo pasta ###########"

rm -rf controlefinanceiro-front/
echo "######### done ###########"
