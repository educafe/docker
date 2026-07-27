FROM nginx:alpine

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the port Nginx will listen on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
