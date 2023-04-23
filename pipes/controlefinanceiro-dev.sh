#!/bin/bash
cd /opt/workspace/

rm -rf controlefinanceiro

git clone https://github.com/hugopaul/controlefinanceiro.git

cd controlefinanceiro

git branch develop

git pull

docker build -t=hugopaul/controlefinanceiro-dev -f Dockerfile-dev .

docker rm controlefinanceiro-dev -f

docker run -d -p 8081:8081 --name  controlefinanceiro-dev  hugopaul/controlefinanceiro-dev

rm -rf controlefinanceiro/