FROM ubuntu:20.04
ONBUILD RUN touch /welcome.txt
ONBUILD RUN echo "Thank you for using myimage" > /welcome.txt

# When an image is built based on an image that is built by Dockerfile 
# having ONBUILD keyword, any command following ONBUILD keyword in the base image 
# will then be valid in the newly built image

