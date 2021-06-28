==========================================================================
docker-compose를 이용하여 nginx 웹 서버와 app.py 웹 어플리케이션을 분리하여 구성
==========================================================================
1) 참조 사이트의 내용을 인용하여 
2) docker-compose.yml 파일에 volume과 environment를 추가
3) Browser에서 <host-ip-addr>을 입력하면 app.py 결과가 반환되도록 하는 웹 어플리케이션
4) 웹 어플리케이션은 app 디렉토리에서 python 이미지를 빌드하여 실행하도록 되어있고
4) nginx 서비스에서 8080:80 포트로 매핑되도록 docker-compose.yml 파일에 구성
5) Dockerfile 파일에서 WORKDIR /app -> WORKDIE /code로 변경함으로써
--> 컨테이너가 실행 중에 app.py가 갱신되면 갱신된 내용이 실시간 반영
6) nginx.conf 파일을 원본과 같이 수정
--> upstream app 부분에 자동으로 생성되는 lab_app_1, lab_app_2 등으로 구성하여 2개의 컨테이너 사이에 트래픽 분산

참조 :
--------------------------------------------------------------------------------------------
Building a Python scalable Flask application using docker-compose and Nginx load balancer
--------------------------------------------------------------------------------------------
https://www.linkedin.com/pulse/building-python-scalable-flask-application-using-nginx-itay-melamed

해당 링크는 2개의 웹 어플리케이션 컨테이너가 실행되도록 nginx.conf 파일이 구성되어 있으며, 
single 컨테이너로 동작하도록 수정.