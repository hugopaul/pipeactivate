#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/lourivalekamyla-front
echo "######### done ###########"

echo "#########  dando pull na branch ###########"
git reset --hard

git checkout main
git fetch
git pull origin main --rebase
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