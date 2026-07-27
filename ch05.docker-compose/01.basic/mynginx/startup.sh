#!/bin/bash
echo "I am $(hostname -I)" > /usr/share/nginx/html/index.html
nginx -g "daemon off;"

