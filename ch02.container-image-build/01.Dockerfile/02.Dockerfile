FROM nginx:latest
RUN echo "I am $(uname -n) at $(hostname -I)" > /usr/share/nginx/html/index.html

