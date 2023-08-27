FROM myubuntu:utils
ADD version2.sh .
CMD ["/bin/bash", "-c", "./version2.sh"]
