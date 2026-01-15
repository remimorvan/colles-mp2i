#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

struct s_grid {
	int x;
	int y;
	int *grid;
	int *visibility;
};

typedef struct s_grid grid;

grid *new_grid(int x, int y) {
	grid *g = malloc(sizeof(grid));
	assert(g != NULL);
	assert(x >= 0 && y >= 0);
	g->x = x;
	g->y = y;
	g->grid = calloc(x * y, sizeof(int));
	g->visibility = calloc(x * y, sizeof(int));
	assert(g->grid != NULL);
	assert(g->visibility != NULL);
	return g;
}

int get_element(grid *g, int i, int j) {
	assert(i >= 0 && i < g->x);
	assert(j >= 0 && j < g->y);
	return g->grid[i + g->x * j];
}

void set_element(grid *g, int i, int j, int val) {
	assert(i >= 0 && i < g->x);
	assert(j >= 0 && j < g->y);
	g->grid[i + g->x * j] = val;
}

int is_visible(grid *g, int i, int j) {
	assert(i >= 0 && i < g->x);
	assert(j >= 0 && j < g->y);
	return g->visibility[i + g->x * j];
}

void set_visibility(grid *g, int i, int j, int val) {
	assert(i >= 0 && i < g->x);
	assert(j >= 0 && j < g->y);
	g->visibility[i + g->x * j] = val;
}

void print_grid(grid *g) {
	assert(g->y <= 26);
	char *emojis[] = {"💩", "🦖", "🌈", "🍓", "🥺", "🏰",  "🦄",
					  "🏆", "🌲", "🐈", "🦆", "🧠", "🎉",  "🐒",
					  "🏹", "🐳", "🌝", "📕", "⚽️", "🥸 ", "🦤 "};
	printf("\e[1;1H\e[2J");
	printf("  ");
	for (int i = 0; i < g->x; i++)
		printf("%d  ", i);
	printf("\n");
	for (int j = 0; j < g->y; j++) {
		printf("%c ", "ABCDEFGHIJKLMNOPQRSTUVWYZ"[j]);
		for (int i = 0; i < g->x; i++) {
			assert(get_element(g, i, j) < 21);
			printf("%s ",
				   is_visible(g, i, j) ? emojis[get_element(g, i, j)] : "? ");
		}
		printf("\n");
	}
}

void delete_grid(grid *g) {
	free(g->grid);
	free(g->visibility);
	free(g);
}

void random_init_grid(grid *g) {
	int n = g->x * g->y;
	assert(n % 2 == 0);
	srand(time(NULL));
	// Initialize with pairs: 0, 0, 1, 1, 2, 2, ..., n/2-1, n/2-1
	for (int k = 0; k < n; k++) {
		g->grid[k] = k / 2;
	}
	// Fisher-Yates shuffle
	for (int k = n - 1; k > 0; k--) {
		int r = rand() % (k + 1);
		int tmp = g->grid[k];
		g->grid[k] = g->grid[r];
		g->grid[r] = tmp;
	}
}

int is_game_finished(grid *g) {
	for (int i = 0; i < g->x; i++) {
		for (int j = 0; j < g->y; j++) {
			if (!is_visible(g, i, j)) {
				return 0;
			}
		}
	}
	return 1;
}

int main(int argc, char **argv) {
	int x = 5;
	int y = 4;
	grid *g = new_grid(x, y);
	random_init_grid(g);
	while (!is_game_finished(g)) {
		print_grid(g);
		char i = '\0', j = '\0';
		int y1, x1;
		do {
			fscanf(stdin, " %c%c", &i, &j);
			y1 = i - 'A';
			x1 = j - '0';
		} while (y1 < 0 || y1 >= g->y || x1 < 0 || x1 >= g->x);
		set_visibility(g, x1, y1, 1);
		print_grid(g);
		int y2, x2;
		do {
			fscanf(stdin, " %c%c", &i, &j);
			y2 = i - 'A';
			x2 = j - '0';
		} while (y2 < 0 || y2 >= g->y || x2 < 0 || x2 >= g->x);
		set_visibility(g, x2, y2, 1);
		print_grid(g);
		sleep(2);
		if (get_element(g, x1, y1) != get_element(g, x2, y2) &&
			((x1 != x2) || (y1 != y2))) {
			set_visibility(g, x1, y1, 0);
			set_visibility(g, x2, y2, 0);
		}
	}
	delete_grid(g);
	return 0;
}