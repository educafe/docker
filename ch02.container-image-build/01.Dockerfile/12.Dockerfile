FROM ubuntu:24.04
COPY a.out .
CMD ["./a.out"]
STOPSIGNAL SIGINT


