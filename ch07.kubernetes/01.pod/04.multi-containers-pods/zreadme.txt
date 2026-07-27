여기서 사용하는 nginx와 myapp은 docker-compose에서 사용한 것을 그대로 구성하고 nginx-conf 파일을 수정
--> server 127.0.0.1:5000
-----------------------------------------------------------------
시나리오 1
--------------
mynginx와 myapp 어플리케이션이 동일한 pod 내에서 컨테이너로 동작하는 경우
-------------------------------------------------------------------------------------------
1) 01.nginx_config_sp.yml 파일을 실행하여 nginx의 configuration을 적용 (kubectl get cm)
2) 01-1.multi-containers-myapp.yml을 실행하여 mypod 실행 (kubectl get pods -o wide)
3) pod ip 주소로 접속하여 myapp 어플리케이션이 동작하는지 확인 (curl <mypod-ip>)
4) mypod를 삭제한 후 다시 생성하여 pod ip 주소로 접속 확인

시나리오 2
--------------
mynginx와 myapp 어플리케이션이 각기 다른 pod에서 컨테이너로 동작하는 경우
-------------------------------------------------------------------------------------------
1) 02-1.myapp.yml 파일을 실행 -> myapp pod의 ip 주소 확인
2) myapp pod의 ip 주소를 02-2.nginx_config_mp.yml 파일에 적용
	upstream myapp {
                server 10.244.1.39:5000;
            	}
3) 02-3.mynginx.yml 파일을 실행 -> mynginx pod의 ip 주소 확인
4) curl <mynginx ip> 명령으로 확인
5) myapp pod를 삭제한 후 다시 생성한 다음 같은 방법으로 myapp 어플리케이션에 접속 (접속이 안된다)

--> nginx configuration을 수정한 후 다시 적용
--> nginx configuration이 변경되었기 때문에 mynginx pod를 삭제 후 다시 생성
--> mynginx ip 주소로 접속

==> myapp pod나 mynginx pod가 재생성될 때마다 모든 구성을 수정해야 한다.

6) 03.mysvc.yml 파일 적용 --> myapp pod를 자동으로 찾아가도록 하는 서비스
7) 02-02.nginx_config_mp.yml 파일을 수정하여 mysvc 을 이용하여 myapp 어플리케이션에 접속하도록 구성
8) mynginx pod를 삭제 후 다시 생성 (새로운 configuration 적용)

---> 이후부터는 myapp pod가 삭제된 후 다시 생성이 되어서 myapp 어플리케이션 접속 방법은 변함이 없다