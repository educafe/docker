#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>


int main(){
	int fd;
	char data[128];
	int ret;
	
	for(int i=0; ; i++){
		fd=open("/app/file01", O_RDONLY);
		if(fd == -1)
			perror("open");
		else
			break;
		sleep(1);
	}
	for(int i; ; i++){
		memset(data, 0, sizeof(data));
		ret=read(fd, data, sizeof(data));
		
		if(ret == 0)
			break;
		printf("%s", data);
		fflush(stdout);
		sleep(2);
	}
	close(fd);
	return 0;
}