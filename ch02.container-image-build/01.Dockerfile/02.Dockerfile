FROM ubuntu:18.04

USER root
RUN apt-get update
RUN apt-get -y install apache2 && apt-get clean
#RUN echo "Welcome to Apache2 Web Server" > /var/www/html/index.html
	
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]

#FROM httpd
#COPY index.html /usr/local/apache2/htdocs/
