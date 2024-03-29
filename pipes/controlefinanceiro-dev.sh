#!/bin/bash

sh /opt/workspace/pipeactivate/pipes/build-dev.sh &
sleep 1m

cd /opt/workspace/controlefinanceiro
echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-dev" -f
echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 8081:8081 --name  controlefinanceiro-dev  hugopaul/controlefinanceiro-dev --memory=100m
echo "######### done ###########"
echo "######### removendo pasta ###########"

rm -rf controlefinanceiro/
echo "######### done ###########"
