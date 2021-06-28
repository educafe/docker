FROM node:alpine
MAINTAINER educafe <edu4cafe@gmail.com>
ADD . /srv/app
WORKDIR /srv/app
RUN npm install
EXPOSE 80
ENTRYPOINT ["node", "index.js"]
