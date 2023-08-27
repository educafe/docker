#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>

void handler(int signo){
	dprintf(1,"Container received a signal #%d\n", signo);
	if(signo != 28 && signo != 15) {
		exit(1);
	} else
		for(;;) {
			dprintf(1,"I will be dead soon\n");
			sleep(5);
		}
			
}
int main(){
	int fd;
	char buf[512];
	char fname[64];
	char hostname[32];
	unsigned char ip_address[15];
  struct ifreq ifr;
	
	for(int i=1; i<31; i++){
		if(i !=9 || i != 19)
			signal(i, handler);
	}
	
	gethostname(hostname, sizeof hostname);
	sprintf(fname, "/app/file.%s", hostname);
	
	fd = socket(AF_INET, SOCK_DGRAM, 0);
	ifr.ifr_addr.sa_family = AF_INET;
	memcpy(ifr.ifr_name, "eth0", IFNAMSIZ - 1);
	ioctl(fd, SIOCGIFADDR, &ifr);
	close(fd);
	strcpy(ip_address, inet_ntoa(((struct sockaddr_in*)&ifr.ifr_addr)->sin_addr));
	
	for(int i=0; ;i++){
		fd=open(fname, O_WRONLY | O_CREAT | O_APPEND, 0664);
		if(fd == -1){
			perror("open");
			sleep(5);
			continue;
		}
		memset(buf, 0, sizeof(buf));
		sprintf(buf, "I am %s with value of (%d)\n", ip_address, i);
		write(fd, buf, strlen(buf));
		close(fd);
		sleep(5);
	}
	return 0;
}


