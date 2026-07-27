FROM ubuntu:24.04
RUN mkdir /tmp/mydir1
COPY Dockerfile /tmp/mydir1
CMD ["Hello World"]
WORKDIR /tmp/mydir1
ENTRYPOINT ["echo"]


