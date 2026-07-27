FROM nginx:latest
WORKDIR /usr/share/nginx/html
RUN echo "I am $(uname -n) at $(hostname -I)" > index.html




