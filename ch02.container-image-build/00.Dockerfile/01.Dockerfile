FROM nginx:latest

COPY ./index.html /usr/share/nginx/html/index.html

VOLUME "/usr/share/nginx/html/"

ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off;"]

EXPOSE 80

