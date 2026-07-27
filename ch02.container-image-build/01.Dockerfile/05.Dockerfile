FROM ubuntu:24.04
RUN mkdir /tmp/mydir1
COPY Dockerfile /tmp/mydir1
CMD ["pwd"]
WORKDIR /tmp/mydir1



