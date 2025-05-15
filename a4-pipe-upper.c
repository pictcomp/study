#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <ctype.h>
#include <string.h>

int main() {
    int fd1[2], fd2[2];
    char input[50], output[50];
    pid_t x;
   
    pipe(fd1);
    pipe(fd2);
   
    x = fork();
   
    if (x == 0) {
        close(fd1[1]);
        close(fd2[0]);
       
        read(fd1[0], input, sizeof(input));
        close(fd1[0]);
       
    
        for (int i = 0; input[i] != '\0'; i++) {
            if (islower(input[i])) {
                input[i] = toupper(input[i]);
            }
        }
       
        write(fd2[1], input, strlen(input) + 1);
        close(fd2[1]);
    } else {
        close(fd1[0]);
        close(fd2[1]);
       
        printf("Enter a word: ");
        scanf("%s", input);
       
        write(fd1[1], input, strlen(input) + 1);
        close(fd1[1]);
       
        read(fd2[0], output, sizeof(output));
        close(fd2[0]);
       
        printf("Modified word from child: %s\n", output);
    }
   
    return 0;
}
