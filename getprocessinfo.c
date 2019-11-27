#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    int pid = atoi(argv[1]);
    struct processInfo procInfo;
    getprocinfo(pid, &procInfo);
    printf(1,"%d\n",procInfo.pid);
    exit();
}
