FROM ubuntu:22.04
ADD a.out .
ENV PATH=.:$PATH
ENTRYPOINT ["a.out"]
CMD ["3"]





