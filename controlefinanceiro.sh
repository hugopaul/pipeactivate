#!/bin/bash
git clone https://github.com/hugopaul/imslandingpage.git

cd imslandingpage/

docker build -t=hugopaul/imslandingpage .

docker rm imslandingpage -f

docker run -d -p 90:80 --name  imslandingpage  hugopaul/imslandingpage

cd /

rm -rf imslandingpage/