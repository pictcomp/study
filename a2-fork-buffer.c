#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>

int main()
{
    int fd[2];
    char buff[10];
    pid_t x;
    pipe(fd);
    x = fork();
    if(x==0)
    {
        close(fd[1]);
        read(fd[0], buff, 6);
        printf("msg=%s\n", buff);
    }
    else
    {
        close(fd[0]);
        write(fd[1], "Hello", 6);
        close(fd[1]);
    }
    return 0;
}