bionic.tar, focal.tar 파일은
sudo debootstrap bionic bionic
sudo debootstrap focal focal 명령을 사용하여 다운로드 받은 bionic과 focal 폴더를 tar 명령어로 묶은 것.

해당 파일을 그 자체로 samba를 통해서 Windows로의 복사가 안되기 때문이며,
실습을 할 때는 tar 파일을 리눅스로 복사한 후 owner:group을 모두 root로 바꾼 후 사용하여야 한다
