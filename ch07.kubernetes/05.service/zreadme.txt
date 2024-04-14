1) env10.mp-myapp.yml와 env11.myconfig.yml 및 env12.mp-mynginx.yml  파일을 적용시킨다.
--> 하나의 myapp과 하나의 nginx 서버가 실행
--> env11.myconfig.yml 파일은 env11.mp-nginx.yml 파일의 nginx 서버가 env10.mp-myapp pod의 ip 주소로 proxing을 함. 
--> 따라서 mp-myapp pod의 ip 주소를 수정해 주어야 함
--> nginx의 IP주소로 접속하면 확인할 수 있음. curl <mp-nginx ip>:80 으로 연결

2) 10.svc-clusterip.yml 서비스 파일은 clusterip로 접속하면 nginx로 접속되고 nginx는 proxy 로 동작하여 backend의 myapp으로 접속
--> clusterip로 접속하므로 mp-nginx pod가 새롭게 생성되어도 서비스는 유효하다. 하지만,
--> mp-myapp pod가 다시 생성되면 서비스는 동작하지 않는다. 왜냐하면 mp-mypod의 ip 주소가 바뀌었기 때문이다.
--> 이를 동작하게 만들기 위해서는 myconfig 파일을 수정하여야 한다.

3) 11.svc-clusterip1.yml 파일은 mp-myapp pod에 연결하는 서비스로 clusterip1 ip 주소로 접속하면 mp-myapp에 접속된다
--> mp-myapp pod가 다시 생성되어도 서비스는 연결된다

4) 2)번과 3)번을 결합하면, 즉 10.svc-clusterip.yml 파일의 서비스, 즉 clusterip ip 주소로 접속했을 때 
nginx의 proxing을 svc-clusterip1 IP 주소로 하면 2개의 서비스가 frontend의 nginx에서 backend의 myapp으로 접속할 수 있다
--> myconfig를 env11.myconfig.yml 파일에서 env11-1.myconfig.yml 파일로 대체한다. 
--> 이 때 nginx pod를 다시 생성해야 변경된 구성 파일이 적용된다

5) env13과 env14는 frontend에 2개의 nginx pod를 배치하고 backend에 4개의 myapp pod를 배치한 후
--> 동일한 서비스로 nginx를 load balancing을 하면서 myapp pod 또한 load balancing 하면서 접속된다 