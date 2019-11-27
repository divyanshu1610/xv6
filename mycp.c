#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

char buf[512];

int main(int argc,char* argv[])
{
	int fd1,fd2;
	if(argc!=3)
	{
		printf(1, "Usage: mycp arg1 arg2");
		exit();
	}
	if((fd1=open(argv[1],O_RDONLY))<0){
		printf(1, "mycp: cannot open %s\n", argv[1]);
      exit();
	}
	
	if((fd2=open(argv[2],O_CREATE|O_WRONLY))<0)	
	{
		printf(1, "mycp: cannot create %s\n", argv[2]);
      exit();
	}

	int n;
	while((n = read(fd1, buf, sizeof(buf))) > 0)
	{
		if (write(fd2, buf, n) != n) {
      printf(1, "mycp: write error\n");
      exit();
    }
  
	  if(n < 0){
	    printf(1, "mycp: read error\n");
	    exit();
	  }
}


	close(fd1);
	close(fd2);
	exit();

}