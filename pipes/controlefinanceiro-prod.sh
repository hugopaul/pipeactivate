#!/bin/bash
rm -rf  controlefinanceiro
git clone https://github.com/hugopaul/controlefinanceiro.git

cd controlefinanceiro/

docker build -t=hugopaul/controlefinanceiro-prod -f Dockerfile-prod .

docker rm controlefinanceiro -f

docker run -d -p 8081:8081 --name  controlefinanceiro  hugopaul/controlefinanceiro

cd /

rm -rf controlefinanceiro/