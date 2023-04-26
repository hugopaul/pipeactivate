#!/bin/bash
cd /opt/workspace/controlefinanceiro/
docker build -t=hugopaul/controlefinanceiro-dev -f Dockerfile-dev .
