#!/bin/bash
clear
tput setaf 4
cat << EOC
Docker Engine Installation :
Docker Engine is an open source containerization technology for building 
and containerizing your applications. 
Docker Engine acts as a client-server application with:
A server with a long-running daemon process dockerd
EOC
echo
cat << EOC
Press Enter to install packages to allow apt to use a repository over HTTPS.
EOC

echo
tput setaf 2
read
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common

echo
tput setaf 4
cat << EOC
Press Enter to add Docker’s official GPG key:.
EOC

echo
tput setaf 2
read
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo
tput setaf 4
cat << EOC
Press Enter to set up the stable repository.
EOC

echo
tput setaf 2
read
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo
tput setaf 4
cat << EOC
Press Enter to update the apt package index and
install the latest version of Docker Engine and containerd.
EOC

echo
tput setaf 2
read
# sudo apt-get install docker-ce
sudo apt-get install -y docker-ce docker-ce-cli 
sudo apt-get -y install containerd.io
# curl -sSL https://get.docker.com/ | sh 
# sudo systemctl start docker 

echo
tput setaf 4
cat << EOC
Before installing docker machine and compose, following url informs you of
the latest version of docker-machine and docker-compose.
Docker-machine :
	https://github.com/docker/machine/releases/
Docker-compose :
	https://github.com/docker/compose/releases/

Please press enter to continue to install docker-machine : 
EOC

echo
tput setaf 2
read answer

mkdir ~/bin
curl -L "https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-$(uname -s)-$(uname -m)" > ~/bin/docker-machine
chmod u+x ~/bin/docker-machine

echo
tput setaf 4
cat << EOC
Compose is a tool for defining and running multi-container Docker applications.
Press Enter to install docker compose.
EOC

echo
tput setaf 2
read
# mkdir ~/bin
curl -L https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m) > ~/bin/docker-compose
chmod u+x ~/bin/docker-compose


echo
tput setaf 4
# sudo dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375
cat << EOC
/var/run/docker.sock is owned by root and shared via docker group 
Press Enter to add a user, educafe, to docker group.
EOC

echo
tput setaf 2
read
sudo gpasswd -a educafe docker

echo
tput setaf 4
cat << EOC
Press Enter to install bridge-utils to use brctl command.
EOC

echo
tput setaf 2
read
sudo apt-get -y install bridge-utils

echo
tput setaf 4
cat << EOC
Please re-login to run a command under educafe user
EOC


echo
tput setaf 4
cat << EOC
Press Enter to install cgroup-tools cgcreate, cgexec command.
EOC

echo
tput setaf 2
read
sudo apt install -y cgroup-tools

echo
tput setaf 0
echo "Please continue with next script to complete docker environment building "
echo
