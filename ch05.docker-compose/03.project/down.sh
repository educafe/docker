#!/bin/bash
docker kill mysql && docker rm mysql
docker kill nodejs && docker rm nodejs
docker kill nginx && docker rm nginx
docker network rm mybridge
docker volume rm db_data
