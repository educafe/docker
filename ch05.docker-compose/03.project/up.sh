#!/bin/bash
docker network create mybridge
docker volume create db_data

docker image build -t mynginx ./nginx
docker image build -t mynodejs ./nodejs
docker image build -t mymysql ./mysql


docker run -d --name mysql --network mybridge -v db_data:/var/lib/mysql mymysql
docker run -d --name nodejs --network mybridge mynodejs
docker run -d --name nginx --network mybridge mynginx