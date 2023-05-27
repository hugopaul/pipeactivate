#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/controlefinanceiro-front
wait
echo "######### done ###########"

echo "#########  dando pull na branch ###########"
git checkout develop
wait

git pull origin develop --rebase
wait
echo "######### done ###########"

#echo "#########  removendo pack lock ###########"
#rm -rf package-lock.json
#wait
#echo "######### done ###########"

echo "#########  npm install ###########"
npm install
wait
echo "######### done ###########"

echo "######### removendo pasta dist ###########"
rm -rf /opt/workspace/controlefinanceiro-front/dist
wait

echo "######### done ###########"

echo "######### buildando projeto ###########"
npm run build
wait # aguarda ng build terminar
echo "######### done ###########"

echo "######### buildando docker ###########"
docker build -f Dockerfile-dev  -t=hugopaul/controlefinanceiro-front-dev .
wait
echo "######### done ###########"

echo "######### removendo imagem antiga ###########"
docker rm "controlefinanceiro-front-dev" -f
wait
echo "######### done ###########"

echo "######### rodando docker ###########"
docker run -d -p 100:80 --name  controlefinanceiro-front-dev  hugopaul/controlefinanceiro-front-dev
echo "######### done ###########"