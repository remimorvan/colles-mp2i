#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Correction d'une boucle while],
  language: "théorique",
  difficulty: 2,
  themes: ("correction", )
)

On considère la fonction suivante en C :
```c
int get_first(int *arr, int n) {
	int i = 0;
	while (i < n && arr[i] < 42) {
		i++;
	}
	return i;
}
```
Démontrez que la fonction `get_first`, sur un tableau `arr`, de taille `n`, retourne
- le plus petit indice `i` tel que `arr[i] >= 42`, si un tel indice existe ;
- `n`, sinon.

_Remarque :_ Ne pas sous-estimer la difficulté de cet exercice pour les étudiants les moins rigoureux.
D'habitude on peut oublier de parler dans l'invariant de la condition de la boucle, et s'en sortir par 
une petite arnaque (du style « on voit bien que »).
Si on fait cette erreur ici, il ne reste plus grand chose dans l'invariant…
C'est donc un très bon exercice pour apprendre la rigueur,
mais il est beaucoup plus difficile que le précédent.