#!/bin/bash
docker image build -t myimage .
docker network create -d bridge mybridge
for i in {1..3}
do
	docker run -itd --rm --name mycontainer$i --network mybridge myimage
done

