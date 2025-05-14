#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <sys/wait.h>

void do_parent(int num[], int sz)
{
    int s = 0;
    for (int i = 0; i < sz; i++)
    {
        s = s + num[i];
    }
    printf("Sum of array elements = %d\n", s);
}

void do_child(int num[], int sz)
{
    int m = 1;
    for (int i = 0; i < sz; i++)
    {
        m = m * num[i];
    }
    printf("Product of array elements = %d\n", m);
}

int main()
{
	pid_t x;
	int num[100] ,sz;
	printf("enter size:\n");
	scanf("%d",&sz);
 
	printf("enter array\n");
	for(int i=0;i<sz;i++)
	{
	scanf("%d",&num[i]);
	}
	printf("before fork call\n");
 
	x=fork();
 
	if (x==0)
	{
		printf("in child process x=%ld\n",(long)x);
		do_child(num,sz);
	}
	else
	{
		wait(NULL);
		printf("in parent process x=%ld\n",(long)x);
		do_parent(num,sz);
	}
return 0;
}