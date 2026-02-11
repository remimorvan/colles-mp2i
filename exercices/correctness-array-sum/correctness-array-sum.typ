#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Correction et terminaison d'une somme sur un tableaux],
  language: "théorique",
  difficulty: 1,
  themes: ("correction", "terminaison", "complexité"),
) 

```c
int array_sum(int *arr, int n) {
	assert(arr != NULL);
	assert(n >= 0);
	int sum = 0;
	int i = 0;
	while (i < n) {
		sum = sum + arr[i];
		i++;
	}
	return sum;
}
```
+ Démontrez que la fonction `array_sum` termine sur toute entrée.
+ Déterminez la complexité temporelle de cette fonction.
+ Démontrez sa correction, c'est-à-dire que ```c array_sum(int *arr, int n)``` retourne la somme des `n` premiers éléments du tableau `arr` pour tout entier positif $n$.