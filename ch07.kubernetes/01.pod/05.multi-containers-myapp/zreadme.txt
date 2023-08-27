여기서 사용하는 nginx와 myapp은 docker-compose에서 사용한 것을 그대로 구성하고 nginx-conf 파일을 수정
--> 127.0.0.1:5000
-----------------------------------------------------------------
myapp 실행 방법(2)
-------------------
nginx_config 파일을 별도의 .yml 파일로 적용
1) kubectl apply -f 01.nginx-config.yml 적용
2) 02.multi-container-myapp.yml 적용 (해당 yml 파일에 configmap 정보가 포함되어 있음)
--> kubectl apply -f 05-1.mult-container-myapp.yml
3) CLI 명령으로 해당 pod를 서비스로 노출 또는 03.multi-container-myapp-service.yml 적용
(kubectl expose  pod mc-myapp --type=NodePort --port=80)`
4) curl 명령과 윈도우 브라우저에서 연결