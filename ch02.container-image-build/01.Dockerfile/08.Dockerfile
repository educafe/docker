FROM ubuntu:22.04
RUN echo 'root:docker' | chpasswd
RUN useradd -m educafe && echo 'educafe:ubuntu' | chpasswd
USER educafe
WORKDIR /home/educafe/
CMD /bin/bash

