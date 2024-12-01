#!/bin/bash
docker network create mybridge

docker image build -t myapp ./app
docker image build -t mynginx ./nginx

docker run -d --name myapp --network mybridge myapp
docker run -d --name nginx --network mybridge -p 80:80 mynginx