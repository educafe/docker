docker compose -f 01.docker-compose.yml up -d와 같이 실행하거나,
01.docker-compose.yml 파일을 docker-compose.yml 파일로 복사한 후 실행.

app-read.c
--------------
myimage:latest를 먼저 삭제하고,
1) app-read.c 파일로 a.out을 생성한 후 compose 실행
2) ./update.sh 스크립트를 실행
3) 호스트기 데이터를 생성하고, 컨테이너가 데이터를 분석/처리 하는 상황을 가장 
4) 로그 파일을 통해서 호스트의 스크립트가 update(생성)한 파일 내용을 컨테이너가 읽어어 출력

app-write.c
--------------
myimage:latest를 먼저 삭제하고,
1) app-write.c 파일로 a.out을 생성한 후 compose 실행
2) 컨테이너가 생성하는 데이터를 호스트가 분석/처리하는 상황을 가장
3) 호스트의 파일을 tail -f 로 읽어서 컨테이너가 생성하는 데이터를 출력

app-write-fname.c
-------------------
myimage:latest를 먼저 삭제하고,
1) app-write-fname.c 파일로 a.out을 생성한 후 compose 실행
2) 컨테이너가 생성하는 데이터를 개별적으로 분석/처리하는 상황을 가장
3) 호스트의 파일을 tail -f 로 읽어서 컨테이너가 생성하는 데이터를 출력