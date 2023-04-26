#!/bin/bash
cd /opt/workspace/controlefinanceiro/
docker build -t=hugopaul/controlefinanceiro-prod -f Dockerfile-prod .
