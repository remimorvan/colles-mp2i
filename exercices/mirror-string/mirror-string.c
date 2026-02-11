#include <assert.h>
#include <stdio.h>
#include <string.h>

void mirror(char *str, char *str_mir) {
	int n = strlen(str);
	for (int i = 0; i < n; i++) {
		str_mir[i] = str[n - i - 1];
	}
	str_mir[n] = '\0';
}

int main(int argc, char *argv[]) {
	char str[100] = "Hello world!";
	char str_mir[100] = "";
	mirror(str, str_mir);
	assert(strcmp(str_mir, "!dlrow olleH") == 0);
	return 0;
}
