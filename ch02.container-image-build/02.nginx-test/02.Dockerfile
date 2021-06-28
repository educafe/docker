FROM ubuntu:20.04
RUN apt-get update && apt-get install -y nginx	
COPY index.html /var/www/html
VOLUME ["/var/www/html"]							
CMD ["nginx", "-g", "daemon off;"]									
