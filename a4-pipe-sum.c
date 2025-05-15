#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>


int main()
{
    pid_t x;
    int fd1[2], fd2[2]; //pipes - arrays of file descriptors. fd1[0] is read end, fd1[1] is write end
    int a[10]={1,2,3,4,5,6,7,8,9,10};
    int e, sum=0, result;
    pipe(fd1);
    pipe(fd2);
    x= fork();
    if(x==0) {
        close(fd1[1]);
        while(read(fd1[0],&e, sizeof(e))>0) { // read from pipe, print and add
            printf("e=%d\n", e);
            sum = sum +e;            
        }
    close(fd1[0]);
    close(fd2[0]);
    write(fd2[1], &sum, sizeof(sum));
    close(fd2[1]);
    }
    else
    {
        close(fd1[0]);
        write(fd1[1], a, sizeof(a));
        close(fd1[1]);
        close(fd2[1]);
        while((read(fd2[0],&result, sizeof(result)))>0)
            printf("result=%d\n", result);
        close(fd2[0]);
    }

    return 0;
}
