FROM ubuntu:20.04
RUN mkdir /myvol
RUN echo "hello world" > /myvol/greeting
VOLUME /myvol
	
