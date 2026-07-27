#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>


int main(){
	int fd;
	
	fd=open("/app/file01", O_CREAT | O_RDWR, 0666);
	for(int i; ; i++){
		dprintf(fd,"I am the write container generating value (%d)\n", i);
		sleep(2);
	}
	return 0;
}