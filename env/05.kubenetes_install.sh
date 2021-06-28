#!/bin/bash
# This is the script to install kubenetes on top of docker on ubuntu1804
clear
# To get gpg keys and add repositories
echo
tput setaf 4
cat << EOF
It needs to import google cloud  repository gpg key and add repositories.
Press any key to continue :
EOF

echo
tput setaf 2
read -sn1
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

echo
tput setaf 4
cat << EOF
Please be noted that at the time of writing 
only Ubuntu 16.04 xenial Kubernetes repository is available. 
Replace the below xenial with bionic codename 
once the Ubuntu 18.04 Kubernetes repository becomes available.
kubernetes-yakkety is the latest version at this moment and is expected
be working on ubuntu-bionic(1804).

Enter y to install or n to skip (y/n) :
EOF

echo
tput setaf 2
read -sn1 answer

case $answer in
	[yY]|[yY][eE][sS])
		sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" 
		;;
	[nN]|[nN][oO])
		echo "You chose not to install "
		echo
esac

#To install kubelet, kubeadm, kubectl
echo
tput setaf 4
cat << EOF
Enter y to install kubeadm, kubelet and kubectl or n to skip (y/n) :
EOF

echo
tput setaf 2
read -sn1 answer

case $answer in
	[yY]|[yY][eE][sS])
		sudo apt-get -y install kubeadm kubelet kubectl
		sudo apt-mark hold kubeadm kubelet kubectl
		;;
	[nN]|[nN][oO])
		echo "You chose not to install "
		echo
esac

echo
tput setaf 4
cat << EOF
Currently cgroup driver is cgroup but Kubernetes requires Cgroup driver be systemd.

Enter y to change cgroup driver to systemd or no not to change (y/n) :
EOF

echo
tput setaf 2
read -sn1 answer

case $answer in
	[yY]|[yY][eE][sS])
		cat <<-EOF | sudo tee /etc/docker/daemon.json
		{
		  "exec-opts": ["native.cgroupdriver=systemd"],
		  "log-driver": "json-file",
		  "log-opts": {
			"max-size": "100m"
		  },
		  "storage-driver": "overlay2"
		}
		EOF
		sudo mkdir -p /etc/systemd/system/docker.service.d
		sudo systemctl daemon-reload
		sudo systemctl restart docker
		;;
	[nN]|[nN][oO])
		echo "You chose not to change "
		echo
esac

echo
tput setaf 4
cat << EOF
In order to activate kubernetis cluster, it requires all swap be disabled. 
So now, it disables swap by using swapoff -a command
Enter y to disable swap (y/n) :
EOF

echo
tput setaf 2
read -sn1 answer

case $answer in
	[yY]|[yY][eE][sS])
		sudo swapoff -a
		;;
	[nN]|[nN][oO])
		echo "You chose not to turn off swap function "
		echo
esac

echo
tput setaf 4
cat << EOF
Swap has been disabled. To permanently disable swap when reboot, 
it requires to update fstab file not to enable swap.  
Enter y to update fstab file do disable swap (y/n) :
EOF

echo
tput setaf 2
read -sn1 answer

case $answer in
	[yY]|[yY][eE][sS])
		sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
		;;
	[nN]|[nN][oO])
		echo "You chose not to disable swap disk "
		echo
esac


