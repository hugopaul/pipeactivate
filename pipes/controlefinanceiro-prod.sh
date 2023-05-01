#!/bin/bash
cd /opt/workspace/controlefinanceiro
echo "######### done ###########"
echo "######### removendo imagem antiga ###########"

docker rm "controlefinanceiro-prod" -f
echo "######### done ###########"
echo "######### rodando docker ###########"

docker run -d -p 8082:8082 --name  controlefinanceiro-prod  hugopaul/controlefinanceiro-prod
echo "######### done ###########"
echo "######### removendo pasta ###########"

rm -rf controlefinanceiro/
echo "######### done ###########"
