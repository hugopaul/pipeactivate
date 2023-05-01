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

git checkout develop
echo "######### done ###########"
echo "######### fazendo pull ###########"

git pull
echo "######### done ###########"
echo "######### buildando docker ###########"
sh -x /opt/workspace/pipeactivate/pipes/build-dev.sh

sleep 1m
echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-dev" -f
echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 8081:8081 --name  controlefinanceiro-dev  hugopaul/controlefinanceiro-dev
echo "######### done ###########"
echo "######### removendo pasta ###########"

rm -rf controlefinanceiro/
echo "######### done ###########"
