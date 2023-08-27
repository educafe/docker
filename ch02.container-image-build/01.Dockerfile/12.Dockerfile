FROM mynginx
ADD index.html /var/www/html/index.html
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
