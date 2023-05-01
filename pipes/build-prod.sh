#!/bin/bash
echo "######### entrando diretorio ###########"
cd /opt/workspace/
echo "######### done ###########"
echo "######### removendo diretorio ###########"

rm -rf controlefinanceiro
echo "######### done ###########"
echo "######### clonando projeto ###########"

git clone https://github.com/hugopaul/controlefinanceiro.git
echo "######### done ###########"
echo "######### entrando diretorio clonado ###########"

cd controlefinanceiro
echo "######### done ###########"
echo "######### trocando de branch  ###########"

git checkout prod
echo "######### done ###########"
echo "######### fazendo pull ###########"

git pull
echo "######### done ###########"
echo "######### buildando docker ###########"
docker build -t=hugopaul/controlefinanceiro-prod -f Dockerfile-prod .
