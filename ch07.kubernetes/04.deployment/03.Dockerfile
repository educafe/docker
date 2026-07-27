FROM educafe/myubuntu:utils
ADD version3.sh .
CMD ["/bin/bash", "./version3.sh"]
