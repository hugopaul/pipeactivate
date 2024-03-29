#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/lourivalekamyla-front
echo "######### done ###########"

echo "#########  dando pull na branch ###########"
git checkout main
git pull origin main --rebase
echo "######### done ###########"

#echo "#########  removendo pack lock ###########"
#rm -rf package-lock.json
#echo "######### done ###########"

echo "#########  npm install ###########"
npm install
echo "######### done ###########"

echo "######### removendo pasta dist ###########"
rm -rf /opt/workspace/lourivalekamyla-front/dist
echo "######### done ###########"

echo "######### buildando projeto ###########"
npm run build
wait # aguarda ng build terminar
echo "######### done ###########"

echo "######### buildando docker ###########"
docker build -f Dockerfile  -t=hugopaul/lourivalekamyla-front .
echo "######### done ###########"

echo "######### removendo imagem antiga ###########"
docker rm "lourivalekamyla-front" -f
echo "######### done ###########"

echo "######### rodando docker ###########"
docker run -d -p 5000:80 --restart=always --name lourivalekamyla-front hugopaul/lourivalekamyla-front
echo "######### done ###########"