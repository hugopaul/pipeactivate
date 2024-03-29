#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/controlefinanceiro-front
echo "######### done ###########"

echo "#########  dando pull na branch ###########"
git checkout prod
git pull origin prod --rebase
echo "######### done ###########"

#echo "#########  removendo pack lock ###########"
#rm -rf package-lock.json
#echo "######### done ###########"

echo "#########  npm install ###########"
npm install
echo "######### done ###########"

echo "######### removendo pasta dist ###########"
rm -rf /opt/workspace/controlefinanceiro-front/dist
echo "######### done ###########"

echo "######### buildando projeto ###########"
npm run build
wait # aguarda ng build terminar
echo "######### done ###########"

echo "######### buildando docker ###########"
docker build -f Dockerfile-prod  -t=hugopaul/controlefinanceiro-front-prod .
echo "######### done ###########"

echo "######### removendo imagem antiga ###########"
docker rm "controlefinanceiro-front-prod" -f
echo "######### done ###########"

echo "######### rodando docker ###########"
docker run -d -p 101:80 --restart=always --name controlefinanceiro-front-prod hugopaul/controlefinanceiro-front-prod
echo "######### done ###########"