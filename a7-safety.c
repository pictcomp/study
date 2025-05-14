#include <stdio.h>
#include <stdbool.h>

#define MAX 10

int n, m;
int allocation[MAX][MAX], max[MAX][MAX], need[MAX][MAX], available[MAX];
int safeSequence[MAX];

void calculateNeed() {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            need[i][j] = max[i][j] - allocation[i][j];
}

bool isSafe() {
    int work[MAX];
    bool finish[MAX] = {false};

    for (int i = 0; i < m; i++)
        work[i] = available[i];

    int count = 0;

    while (count < n) {
        bool found = false;
        for (int i = 0; i < n; i++) {
            if (!finish[i]) {
                bool canAllocate = true;
                for (int j = 0; j < m; j++) {
                    if (need[i][j] > work[j]) {
                        canAllocate = false;
                        break;
                    }
                }
                if (canAllocate) {
                    for (int j = 0; j < m; j++)
                        work[j] += allocation[i][j];
                    safeSequence[count++] = i;
                    finish[i] = true;
                    found = true;
                }
            }
        }
        if (!found)
            return false;
    }
    return true;
}

int main() {
    printf("Enter number of processes: ");
    scanf("%d", &n);
    printf("Enter number of resources: ");
    scanf("%d", &m);

    printf("Enter Allocation Matrix:\n");
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            scanf("%d", &allocation[i][j]);

    printf("Enter Maximum Matrix:\n");
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            scanf("%d", &max[i][j]);

    printf("Enter Available Resources:\n");
    for (int i = 0; i < m; i++)
        scanf("%d", &available[i]);

    calculateNeed();

    if (isSafe()) {
        printf("System is in a safe state.\nSafe Sequence: ");
        for (int i = 0; i < n; i++)
            printf("P%d ", safeSequence[i]);
        printf("\n");
    } else {
        printf("System is NOT in a safe state.\n");
    }

    return 0;
}
