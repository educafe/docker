================================================================
docker-compose.yml 파일을 작성하여 다음의 과정을 자동으로 실행하는 예제
================================================================
1) Dockerfile을 이용하여 또는 image pull 명령을 이용하여 nginx 이미지를 만든 후
2) Docker container run 명령으로 containter를 실행시킨 후
3) 현재 디렉토리에 index.html 파일을 위치하여 nginx의 가장 기본적인 웹 서버 서비스를
4) docker-compose.yml 파일을 작성한 후 docker-compose up -d 명령으로 자동화
