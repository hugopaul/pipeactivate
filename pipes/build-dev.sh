#!/bin/bash
echo "######### entrando diretorio ###########"
cd /opt/workspace/
echo "######### done ###########"
echo "######### removendo diretorio ###########"

rm -rf controlefinanceiro
echo "######### done ###########"
echo "######### clonando projeto ###########"

git clone -b develop https://github.com/hugopaul/controlefinanceiro.git
echo "######### done ###########"
echo "######### entrando diretorio clonado ###########"

cd /opt/workspace/controlefinanceiro

echo "######### done ###########"
echo "######### buildando docker ###########"
docker build -t=hugopaul/controlefinanceiro-dev -f Dockerfile-dev .
