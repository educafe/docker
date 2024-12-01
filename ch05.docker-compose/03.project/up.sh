#!/bin/bash
docker network create mybridge
docker volume create db_data

docker image build -t mynginx ./nginx
docker image build -t mynodejs ./nodejs
docker image build -t myqmysl ./mysql


docker run -d --name mysql -p 3306:3306 --network mybridge -v db_data:/var/lib/mysql mymysql
docker run -d --name nodejs -p 3000:3000 --network mybridge mynodejs
docker run -d --name nginx -p 80:80 --network mybridge mynginx