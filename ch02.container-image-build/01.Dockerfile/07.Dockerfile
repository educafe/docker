FROM ubuntu:24.04
RUN mkdir /tmp/mydir1
COPY a.out /tmp/mydir1
ENV PATH=/tmp/mydir1:$PATH
CMD ["a.out", "3"]


