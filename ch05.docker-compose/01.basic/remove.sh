#!/bin/bash
docker kill $(docker ps -q)
docker network rm mybridge


