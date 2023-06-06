#!/bin/bash

echo "######### entrando diretorio ###########"
cd /opt/workspace/landing-lowyer
wait
echo "######### done ###########"

echo "#########  dando pull na branch ###########"
git checkout main
wait

git pull origin main --rebase
wait
echo "######### done ###########"

echo "######### buildando docker ###########"
docker build -f Dockerfile  -t=hugopaul/landing-page .
wait
echo "######### done ###########"

echo "######### removendo imagem antiga ###########"
docker rm "landing-page" -f
wait
echo "######### done ###########"

echo "######### rodando docker ###########"
docker run -d -p 102:80 --name  landing-page  hugopaul/landing-page
echo "######### done ###########"