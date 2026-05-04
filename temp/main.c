#include <stdio.h>

int main() {
    int a, b;
    printf("Enter numbers:
");
    fflush(stdout);
    scanf("%d %d", &a, &b);
    printf("Result: %d
", a + b);
    return 0;
}