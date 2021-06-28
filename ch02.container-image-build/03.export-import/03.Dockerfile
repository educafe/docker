FROM ubuntu:20.04
RUN apt-get update && apt-get install -y nginx
add index.html /var/www/html
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
