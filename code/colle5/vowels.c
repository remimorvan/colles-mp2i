#include <assert.h>
#include <stdio.h>

// Question 1

int in_array(char x, int n, char* arr) {
    for (int i = 0; i < n; i++) {
        if (arr[i] == x) {
            return 1;
        }
    }
    return 0;
}

// Question 2

char vowels[12] = {'a', 'e', 'i', 'o', 'u', 'y', 'A', 'E', 'I', 'O', 'U', 'Y'};

int is_vowel(char c) {
    return in_array(c, 12, vowels);
}

// Question 3

int nb_vowels(char* str) {
    int vow = 0;
    int i = 0;
    while (str[i] != '\0') {
        if (is_vowel(str[i])) {
            vow++;
        }
        // En fait, le if peut même être remplacé par `vow += is_vowel(str[i])`.
        i++;
    }
    return vow;
}

int main(int argc, char** argv) {
    // Test fonction question 1;
    char some_arr[5] = {'c', 'a', 'd', 'b', 'e'};
    assert(in_array('a', 5, some_arr));
    assert(!in_array('a', 1, some_arr));
    char another_arr[0] = {};
    assert(!in_array('z', 0, another_arr));

    // Test fonction is_vowel
    assert(is_vowel('A') && is_vowel('u') && !is_vowel('z') && !is_vowel('B') && !is_vowel('5') && !is_vowel('.'));

    // Test fonction nb_vowels
    char* some_str = "Hello world!";
    assert(nb_vowels(some_str) == 3);
    char* another_str = "Lorem ipsum sit dolor";
    assert(nb_vowels(another_str) == 7);

    return 0;
}