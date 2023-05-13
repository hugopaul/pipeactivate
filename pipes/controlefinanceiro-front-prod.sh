#!/bin/bash

echo "######### entrando diretorio ###########"

cd /opt/workspace/controlefinanceiro-front
echo "######### done ###########"

echo "#########  dando pull na branch ###########"

git checkout prod

git pull

echo "######### done ###########"

echo "#########  npm install ###########"

npm install

echo "######### done ###########"
echo "######### removendo pasta dist ###########"

rm -rf /opt/workspace/controlefinanceiro-front/dist

echo "######### done ###########"
echo "######### buildando projeto ###########"

ng build --configuration=prod --base-href=/controle/

sleep 1m
echo "######### done ###########"
echo "######### buildando docker ###########"

docker build -f Dockerfile-prod  -t=hugopaul/controlefinanceiro-front-prod .

echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-front-prod" -f

echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 101:80 --name  controlefinanceiro-front-prod  hugopaul/controlefinanceiro-front-prod
echo "######### done ###########"
