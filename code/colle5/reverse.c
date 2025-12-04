#include <stdio.h>
#include <string.h>

void reverse(char* str, char* str_rev) {
    int n = strlen(str);
    for (int i = 0; i < n; i++) {
        str_rev[i] = str[n - i - 1];
    }
    str_rev[n] = '\0';
}

int main(int argc, char** argv) {
    char str[100] = "Hello world!";
    char str_rev[100] = "";
    reverse(str, str_rev);
    printf("%s\n", str_rev);
    return 0;
}
