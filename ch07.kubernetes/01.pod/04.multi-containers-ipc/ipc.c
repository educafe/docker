#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>
#include <mqueue.h>

#define MAX_SIZE  1024
#define PROC_FLAG  "-producer"
int producer();
int consumer();

int main(int argc, char *argv[]) {
    if (argc < 2) {
        producer();
    }
    else if (argc >= 2 && 0 == strncmp(argv[1], PROC_FLAG, strlen(PROC_FLAG))) {
        producer();
    }
    else {
        consumer();
    }
}

int producer() {
    mqd_t mq;
    struct mq_attr attr;
    char buffer[MAX_SIZE];
    char *msg;
	int i;

    attr.mq_flags = 0;
    attr.mq_maxmsg = 10;
    attr.mq_msgsize = MAX_SIZE;
    attr.mq_curmsgs = 0;

    mq = mq_open("/ipc-pod", O_CREAT | O_WRONLY, 0644, &attr);

    i = 0;
    while (i < 10) {
        msg = "I am sending -----";
        memset(buffer, 0, MAX_SIZE);
        sprintf(buffer, "%s %d", msg, i);
        // printf("Sent: %s\n", buffer);
        fflush(stdout);
        mq_send(mq, buffer, MAX_SIZE, 0);
        i=i+1;
		sleep(2);
    }
    memset(buffer, 0, MAX_SIZE);
    sprintf(buffer, "done");
    mq_send(mq, buffer, MAX_SIZE, 0); 
	
    mq_close(mq);
	sleep(5);
    mq_unlink("/ipc-pod");
    return 0;
}

int consumer() {
    struct mq_attr attr;
    char buffer[MAX_SIZE + 1];
    ssize_t bytes_read;
    mqd_t mq = mq_open("/ipc-pod", O_RDONLY);
    if ((mqd_t)-1 == mq) {
        dprintf(1,"Either the producer has not been started or \
		maybe I cannot access the same memory...\n");
        exit(1);
    }
    do {
        bytes_read = mq_receive(mq, buffer, MAX_SIZE, NULL);
        buffer[bytes_read] = '\0';
        dprintf(1, "Received: %s\n", buffer);
    } while (0 != strncmp(buffer, "done", strlen("done")));

    mq_close(mq);
    return 0;
}
