#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Retournement de chaîne],
  language: "c",
  difficulty: 2,
  themes: ("tableaux", "mémoire"),
	source: [#link("https://www.labri.fr/perso/fmoranda/pg101/")[Cours de C de Floréal Morandat à l'ENSEIRB.]]
)

+ Écrire une fonction\
	```c void reverse(char* str, char* str_rev)```\
	qui prend deux chaînes de caractères `str` et `str_rev`, et qui
	écrit sur `str_rev` le miroir de `str`. Le miroir est obtenu
	en lisant la chaîne de droite à gauche. Par exemple, le renversé
	de "Hello world!" est "!dlrow olleH".
	On supposera que la chaîne `str_rev` est de taille suffisante pour stocker le résultat.

	Vous pourrez tester votre code avec la fonction `main` suivante.
	```c
	int main(int argc, char** argv) {
			char str[100] = "Hello world!";
			char str_rev[100] = "";
			reverse(str, str_rev);
			printf("%s\n", str_rev);
			return 0;
	}
	```
+ Dessinez l'état de la mémoire avant l'appel de `reverse`, puis juste avant le retour de la fonction `reverse`.