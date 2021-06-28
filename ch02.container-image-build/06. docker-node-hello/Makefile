install:
	npm install

build:
	docker build -t example/docker-node-hello:latest .

run:
	node index.js

run-container:
	docker run -p 8080:8080 -d example/docker-node-hello 

test:
	curl localhost

clean:
	rm -rf node_modules


.PHONY: install build run test clean
