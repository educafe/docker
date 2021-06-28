#!/bin/bash
clear
if [ $UID -ne 0 ];then
	echo "Please try again with sudo"
	exit 1
fi
echo
tput setaf 4
cat << EOC
In orde to limit memory usage for a single Linux process,
it requires to change the file /etc/default/grub so that either 
GRUB_CMDLINE_LINUX_DEFAULT or GRUB_CMDLINE_LINUX contains 
GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
And then, execute the command update-grub and reboot
EOC

# vi /etc/default/grub

echo 
cat << EOC
Please press enter to modify /etc/default/grub to contain 
GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
EOC

read

echo GRUB_CMDLINE_LINUX='"cgroup_enable=memory swapaccount=1"' >> /etc/default/grub

if [ $? -eq 0 ]; then
	tput seraf 2
	echo "/etc/default/grub file is successfully updated?"
else
	tput setaf 1
	echo "update of /etc/default/grub file failed, Try again"
fi

echo 
tput setaf 4
cat << EOC
Please press enter to apply updated /etc/default/grub
EOC

echo
tput setaf 2
read
update-grub

echo 
tput setaf 4
cat << EOC
Please press enter to reboot the system 
EOC

read
reboot

