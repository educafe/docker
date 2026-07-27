#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main() {
    const size_t chunk = 10 * 1024 * 1024;      // 10 MB
    size_t total = 0;
    void **blocks = NULL;
    size_t cap = 0, n = 0;

    while (1) {
        void *p = malloc(chunk);
        if (!p) {
            perror("malloc");
            fprintf(stderr, "Stopped at ~%zu MB\n", total / (1024 * 1024));
            sleep(60); // give time to inspect cgroup before exit if not killed
            return 1;
        }
        memset(p, 0xAB, chunk);                 // touch pages so they count
        total += chunk;

        if (n == cap) {
            cap = cap ? cap * 2 : 16;
            blocks = realloc(blocks, cap * sizeof(void*));
        }
        blocks[n++] = p;

        fprintf(stderr, "Allocated ~ %zu MB\n", total / (1024 * 1024));
        usleep(100000);                         // slow down a bit
    }
}


/*
systemd-run --scope --user -p MemoryAccounting=yes -p MemoryMax=400M -p MemorySwapMax=0 ./oom

UNIT=run-12345.scope (systemd-run 시 출력된다)
systemctl show -p MemoryMax -p MemoryCurrent $UNIT

CGDIR=$(systemctl show -p ControlGroup --value $UNIT)
cat /sys/fs/cgroup$CGDIR/memory.max
cat /sys/fs/cgroup$CGDIR/cgroup.events
*/


