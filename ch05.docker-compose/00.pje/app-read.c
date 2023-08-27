#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>


void handler(int signo){
	dprintf(1,"Container received a signal #%d\n", signo);
	if(signo != 28 && signo != 15) {
		exit(1);
	} else
		for(;;) {
			dprintf(1,"I will be dead soon\n");
			sleep(1);
		}
			
}
int main(){
	int fd;
	char buf[512];
	char hostname[512];
	char *IPbuffer;
	struct hostent *host_entry;
	
	for(int i=1; i<31; i++){
		if(i !=9 || i != 19)
			signal(i, handler);
	}
	
	gethostname(hostname, sizeof hostname);
	host_entry = gethostbyname(hostname);
	IPbuffer = inet_ntoa(*((struct in_addr*)host_entry->h_addr_list[0]));
	
	for(int i=0; ;i++){
		fd=open("/app/file01", O_RDONLY);
		if(fd == -1){
			perror("open");
			sleep(5);
			continue;
		}
		memset(buf, 0, sizeof(buf));
		read(fd, buf, sizeof(buf));
		dprintf(1, "%s\t", IPbuffer);
		dprintf(1, "%s\n", buf);
		close(fd);
		sleep(5);
	}
	return 0;
}


