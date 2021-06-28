FROM ubuntu:20.04

RUN apt-get update && apt-get install -y gcc
WORKDIR /tmp
COPY a.c .
RUN gcc a.c
CMD ["./a.out", "3"]

