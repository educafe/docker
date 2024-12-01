1) 각 디렉토리에서 이미지를 build 한다
--> docker image build -t mysql .
--> docker image build -t nodejs .
--> docker image build -t nginx .

2) 컨테이너간 네트워크를 위한 webnet을 생성한다
--> docker network create mybridge

3) DB의 경우 필요한 데이터 저장을 위해 volume mount를 생성한다
--> docker volume create db_data

4) 다음의 순서로 컨테이너를 실행시킨다
--> docker run -d --name mysql --network mybridge -p 3306:3306 mymysql 
--> docker run -d --name nodejs --network mybridge -p 3000:3000 mynodejs
--> docker run -d --name nginx --network mybridge -p 80:80 mynginx