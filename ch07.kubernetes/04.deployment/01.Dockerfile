FROM myubuntu:utils
ADD version1.sh .
CMD ["/bin/bash", "-c", "./version1.sh"]
