#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

char name[512];
void handler(int signo){
	dprintf(1,"Container received a signal #%d\n", signo);
	if(signo != 28) {
		if(signo == 15){
			for(int i=1; i<=15; i++) {
				dprintf(1,"I will be dead soon(%d) ---- %s\n", i, name);
				sleep(3);
			}
			exit(0);
		}
	} 
}

int main(){
	gethostname(name, sizeof(name));
	for(int i=1; i<31; i++){
		if(i !=9 || i != 19)
			signal(i, handler);
	}
	for(int i=0; ;i++){
		dprintf(1, "Hello docker(%d) ---- %s\n", i, name);
		sleep(5);
	}
	return 0;
}


