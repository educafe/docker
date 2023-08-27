03-1.multi-container-shared-volume.xml 실행 방법
-------------------------------------------------
read.c 파일을 컴파일하여 a.out을 생성한 후 Dockerfile을 이용하여 educafe/myread:v1 이미지 생성.
write.c 파일을 컴파일하여 a.out을 생성한 후 Dockerfile을 이용하여 educafe/mywrite:v1 이미지 생성.

kubectl apply -f 03-1.multi-container-shared-volume.xml을 실행한 후
kubectl logs -f mypod -c read 명령을 실행하여 결과 확인
