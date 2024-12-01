#!/bin/bash
docker kill myapp && docker rm myapp 
docker kill nginx && docker rm nginx

docker network rm  mybridge