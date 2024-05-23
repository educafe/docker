FROM nginx:latest
ONBUILD RUN echo "I am $(uname -n) at $(hostname -I)" > /usr/share/nginx/html/index.html

# 10-2.Dockerfile에서 참조하는 이미지 이름으로 이미지를 생성해야 한다
# docker build -t mynginx. -f 10-1.Dockerfile