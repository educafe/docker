#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv[]){
	int i;
	for (i=0; i<atoi(argv[1]); i++){
		printf("Looping ---- %d\n", i);
	}
}