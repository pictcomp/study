#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

// Function for Selection Sort (Parent)
void selectionSort(int arr[], int n) {
    int i, j, min_idx, temp;
    for (i = 0; i < n - 1; i++) {
        min_idx = i;
        for (j = i + 1; j < n; j++)
            if (arr[j] < arr[min_idx])
                min_idx = j;
        // Swap
        temp = arr[min_idx];
        arr[min_idx] = arr[i];
        arr[i] = temp;
    }
}

// Function for Insertion Sort (Child)
void insertionSort(int arr[], int n) {
    int i, key, j;
    for (i = 1; i < n; i++) {
        key = arr[i];
        j = i - 1;

        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}

// Function to print an array
void printArray(int arr[], int n) {
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

int main() {
    int arr[20];
    int i;

    printf("Enter 20 integers:\n");
    for (i = 0; i < 20; i++) {
        scanf("%d", &arr[i]);
    }

    pid_t pid = fork();

    if (pid < 0) {
        printf("Fork failed!\n");
        return 1;
    }

    else if (pid == 0) {
        // Child process
        printf("\n[Child] Performing Insertion Sort...\n");
        int childArr[20];
        for (i = 0; i < 20; i++)
            childArr[i] = arr[i];
        insertionSort(childArr, 20);
        printf("[Child] Sorted Array (Insertion Sort):\n");
        printArray(childArr, 20);
    }

    else {
        // Parent process
        wait(NULL); // Wait for child to complete
        printf("\n[Parent] Performing Selection Sort...\n");
        int parentArr[20];
        for (i = 0; i < 20; i++)
            parentArr[i] = arr[i];
        selectionSort(parentArr, 20);
        printf("[Parent] Sorted Array (Selection Sort):\n");
        printArray(parentArr, 20);
    }

    return 0;
}
