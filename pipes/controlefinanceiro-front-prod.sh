#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/
echo "######### done ###########"

echo "######### removendo diretorio ###########"
rm -rf /opt/workspace/controlefinanceiro-front
echo "######### done ###########"

echo "######### clonando projeto ###########"
git clone -b prod https://github.com/hugopaul/controlefinanceiro-front.git
echo "######### done ###########"

echo "######### entrando diretorio clonado ###########"

cd /opt/workspace/controlefinanceiro-front
echo "######### done ###########"
echo "#########  npm install ###########"

npm install

echo "######### done ###########"
echo "######### removendo pasta dist ###########"

rm -rf /opt/workspace/controlefinanceiro-front/dist

echo "######### done ###########"
echo "######### buildando projeto ###########"

ng build --configuration=prod --base-href=/controle/

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
