#!/bin/bash
rm -rf  controlefinanceiro
git clone https://github.com/hugopaul/controlefinanceiro.git

cd controlefinanceiro/

docker build -t=hugopaul/controlefinanceiro-dev -f Dockerfile-dev .

docker rm controlefinanceiro -f

docker run -d -p 8081:8081 --name  controlefinanceiro  hugopaul/controlefinanceiro

cd /

rm -rf controlefinanceiro/