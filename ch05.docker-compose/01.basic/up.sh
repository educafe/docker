#!/bin/bash
docker network create mybridge

docker image build -t myubuntu ./myubuntu 
docker image build -t mynginx ./mynginx

docker run -itd --name myubuntu-1 --network mybridge --network-alias myubuntu myubuntu
docker run -d --name mynginx-1 --network mybridge --network-alias mynginx  mynginx
docker run -d --name mynginx-2 --network mybridge --network-alias mynginx  mynginx

