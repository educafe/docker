1) Dockerfile을 이용하여 이미지를 생성
--> docker build . -t educafe/myimage:v1

2) 생성된 이미지를 Docker Hub에 등록
--> docker push educafe/myimage:v1

3) Docker Hub에 이미지가 등록된 이후에 swarm service 전개
--> docker service create --replicas 3 --name mysrv educafe/myimage:v1

4) 전개된 서비스 제거
--> docker service rm mysrv