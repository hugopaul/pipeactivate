#!/bin/bash

sh /opt/workspace/pipeactivate/pipes/build-prod.sh &
sleep 1m

cd /opt/workspace/controlefinanceiro
echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-prod" -f
echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 8082:8082 --name  controlefinanceiro-prod  hugopaul/controlefinanceiro-prod --memory=200m
echo "######### done ###########"
echo "######### removendo pasta ###########"

rm -rf controlefinanceiro/
echo "######### done ###########"
