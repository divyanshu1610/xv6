#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
int main(int argc,char *argv[])
{
char str[512]; int sz;
int fd = open(argv[1], O_CREATE | O_RDONLY);

printf(1, "%s\n", argv[2]);
int fd1 = open(argv[2], O_CREATE | O_WRONLY);
while((sz=read(fd, str,512)) > 0)
write(fd1,str,sz);
printf(1,"%d \t %d\n",fd1, fd);
close(fd);
close(fd1);
exit();
}
