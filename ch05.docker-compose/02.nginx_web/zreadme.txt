docker image build . -t myapp (app 디렉토리에서 실행)
docker image build . -t nginx (nginx 디렉토리에서 실행)
docker network create mybridge
docker container run -d --name myapp --network mybridge --restart=always app
docker container run -d --name mynginx --network mybridge --restart=always -p 80:80 nginx

위의 5개의 명령을 순서대로 실행해야만 구축되는 nginx 서버와 app.py 웹 어플리케이션을

docker-compose.yml 파일을 작성한 후 docker-compose up --build -d 명령으로 한번에 해결하는 예제로
docker-compose의 필요성과 잇점을 잘 설명할 수 있음
