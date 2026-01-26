#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct s_cell {
	int val;
	struct s_cell *next;
} Cell;

typedef struct s_queue {
	Cell *first_cell;
	Cell *last_cell;
} Queue;

typedef struct s_queue queue;

Queue *queue_create(void);
void queue_enqueue(Queue *, int);
void queue_print(Queue *);
int queue_peek(Queue *);
int queue_dequeue(Queue *);
int queue_is_empty(Queue *);
void queue_free(Queue *);

void hamming(int);

int main(int argc, char *argv[]) {
	Queue *q = queue_create();
	queue_enqueue(q, 0);
	queue_enqueue(q, 1);
	queue_enqueue(q, 2);
	queue_print(q);
	queue_dequeue(q);
	queue_print(q);
	queue_enqueue(q, 3);
	queue_enqueue(q, 4);
	queue_print(q);
	queue_dequeue(q);
	queue_print(q);
	queue_free(q);
	printf("Hamming:\n");
	hamming(30);
	return 0;
}

Queue *queue_create(void) {
	Queue *q = malloc(sizeof(Queue));
	assert(q != NULL);
	q->first_cell = NULL;
	q->last_cell = NULL;
	return q;
}

void queue_enqueue(Queue *q, int v) {
	assert(q != NULL);
	Cell *new_cell = malloc(sizeof(Cell));
	assert(new_cell != NULL);
	new_cell->val = v;
	new_cell->next = NULL;
	Cell *before_last_cell = q->last_cell;
	if (before_last_cell != NULL) {
		before_last_cell->next = new_cell;
	}
	if (q->first_cell == NULL) {
		q->first_cell = new_cell;
	}
	q->last_cell = new_cell;
}

void queue_print(Queue *q) {
	assert(q != NULL);
	Cell *c = q->first_cell;
	while (c != NULL) {
		printf("%d ", c->val);
		c = c->next;
	}
	printf("\n");
}

int queue_peek(Queue *q) {
	assert(q != NULL);
	assert(q->first_cell != NULL);
	return q->first_cell->val;
}

int queue_dequeue(Queue *q) {
	assert(q != NULL);
	assert(q->first_cell != NULL);
	int val = q->first_cell->val;
	Cell *new_first = q->first_cell->next;
	free(q->first_cell);
	q->first_cell = new_first;
	// Quand la queue n'avait qu'un élément
	if (q->first_cell == NULL) {
		q->last_cell = NULL;
	}
	return val;
}

int queue_is_empty(Queue *q) {
	assert(q != NULL);
	return (q->first_cell == NULL);
}

void queue_free(Queue *q) {
	assert(q != NULL);
	Cell *c = q->first_cell;
	while (c != NULL) {
		Cell *next = c->next;
		free(c);
		c = next;
	}
	free(q);
}

void hamming(int m) {
	assert(m >= 0);
	Queue *h2 = queue_create();
	Queue *h3 = queue_create();
	Queue *h5 = queue_create();
	assert(h2 != NULL && h3 != NULL && h5 != NULL);
	queue_enqueue(h2, 1);
	queue_enqueue(h3, 1);
	queue_enqueue(h5, 1);
	int n = 0;
	while (n < m) {
		// Compute minimum of all queues
		n = queue_peek(h2);
		if (queue_peek(h3) < n)
			n = queue_peek(h3);
		if (queue_peek(h5) < n)
			n = queue_peek(h5);
		// Remove minimum of all queues
		if (queue_peek(h2) == n)
			queue_dequeue(h2);
		if (queue_peek(h3) == n)
			queue_dequeue(h3);
		if (queue_peek(h5) == n)
			queue_dequeue(h5);
		// Add multiples
		queue_enqueue(h2, 2 * n);
		queue_enqueue(h3, 3 * n);
		queue_enqueue(h5, 5 * n);
		printf("%d\n", n);
	}
	queue_free(h2);
	queue_free(h3);
	queue_free(h5);
}