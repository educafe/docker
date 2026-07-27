Test Scenario
=============
Case 1)
env10.sp-myapp.yml
env11.nginx-sp-proxy-config.yml
env12.sp-mynginx.yml

10.svc-frontend-sp.yml
11.svc-backend-sp.yml

단일 nginx pod를 frontend로 proxy 역할을 하도록 구성하고 backend에 단일 myapp pod을 실행시켜 
nginx pod에 접속하면 myapp pod가 응답.

이 경우, env10.sp-myapp.yml 을 이용하여 myapp pod를 삭제한 후 새롭게 생성하면 서비스가 중단된다.
myapp pod의 ip 주소가 변경되었기 때문에  env11.nginx-sp-proxy-config.yml 파일에서 구성정보를 수정한 후
다시 적용을 해야하고, 이에 따라 nginx pod를 다시 구동시켜야 한다.

이를 해결하기 위해 backend에 있는 myapp pod에 접속하기 위한 서비스를 적용한다.
11.svc-backend-sp.yml 파일을 이용하여 서비스를 생성하면 backend에 있는 myapp pod에 해당 서비스를 통하여 
접속이 가능하도록 하고, 이 nginx pod가 이 서비스를 통하여 backend로 접속되도록 ConfigMap 파일을 수정한 후 
frontend에 있는 nginx를 삭제 후 재생성한다. 

이 때 nginx에 접속하기 위해서 nginx ip 주소가 바뀌었으므로 새로운 ip 주소로 접속을 해야한다.
이를 해결하기 위해 frontend에 있는 nginx pod에 접속하는 서비스를 적용한다.
10.svc-frontend-sp.yml

서비스가 적용된 환경에서는 nginx pod나 myapp pod가 새롭게 바뀌어도 서비스 접속 방법은 변하지 않는다

Case 2)
env13.myapp-deploy.yml
env14.nginx-mp-proxy-config.yml
env15.nginx-deploy.yml

12.svc-frontend-mp.yml
13.svc-backend-mp.yml

frontend에 2개의 nginx pod가 동작하고 backend에 4개의 myapp pod가 실행되는 구성.
2개의 nginx pod에 load balancing이 적용되도록 서비스를 적용하고
4개의 myapp pod에 load balancing이 적용되도록 서비스를 적용한다.

서비스가 적용된 환경에서는 어떤 nginx pod나 어떤 myapp pod가 새롭게 바뀌어도 서비스 접속 방법은 변하지 않는다