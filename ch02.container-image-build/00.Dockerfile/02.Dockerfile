FROM ubuntu:20.04

RUN apt-get update > /dev/null && apt-get install -y nginx > /dev/null

COPY ./index.html /var/www/html/index.html

VOLUME "/var/www/html/"

ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off;"]

EXPOSE 80

