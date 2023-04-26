#!/bin/bash
cd /opt/workspace/

rm -rf controlefinanceiro

git clone https://github.com/hugopaul/controlefinanceiro.git

cd controlefinanceiro

git checkout prod

git pull

docker build -t=hugopaul/controlefinanceiro-prod -f Dockerfile-prod .

docker rm controlefinanceiro-prod -f

docker run -d -p 8081:8081 --name  controlefinanceiro-prod  hugopaul/controlefinanceiro-prod

rm -rf controlefinanceiro/