FROM educafe/mybionic:1.0
LABEL maintainer="educafe <edu4cafe@gmail.com>"
LABEL description="Dockerfile to add a user, educafe to bionic verison of ubuntu"

RUN echo 'root:docker' | chpasswd

RUN apt-get update
RUN apt-get install sudo && apt-get clean

RUN useradd -m educafe && echo 'educafe:ubuntu' | chpasswd
USER educafe
WORKDIR /home/educafe/
CMD /bin/bash
