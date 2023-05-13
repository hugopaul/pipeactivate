#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/controlefinanceiro-front
echo "######### done ###########"

echo "#########  dando pull na branch ###########"
git checkout dev
git pull
echo "######### done ###########"

echo "#########  removendo pack lock ###########"
rm -rf package-lock.json
echo "######### done ###########"

echo "#########  npm install ###########"
npm install
echo "######### done ###########"

echo "######### removendo pasta dist ###########"
rm -rf /opt/workspace/controlefinanceiro-front/dist
echo "######### done ###########"

echo "######### buildando projeto ###########"
ng build --configuration=dev --base-href=/controle-dev/
wait # aguarda ng build terminar
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