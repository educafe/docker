#!/bin/bash
docker kill myubuntu-1 && docker rm myubuntu-1 
docker kill mynginx-1 mynginx-2 && docker rm mynginx-1 mynginx-2
docker network rm  mybridge

