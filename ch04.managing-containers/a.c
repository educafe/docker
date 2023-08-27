#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

void handler(int signo){
	dprintf(1,"Signal #%d received\n", signo);
	for(int i=0; i<10; i++){
		dprintf(1,"I will be killed soon -- %d\n", i);
		sleep(5);
	}
}
int main(){
	for(int i=1; i<31; i++){
		if(i !=9 || i != 19)
			signal(i, handler);
	}
	int i=1;
	while(1){
		dprintf(1, "Hello docker ---- %d\n", i);
		i++;
		sleep(5);
	}
	return 0;
}