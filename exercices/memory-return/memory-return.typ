#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Un problème de mémoire],
  language: "c",
  difficulty: 1,
  themes: ("mémoire", "tableaux")
)

+ Le code suivant a un comportement indéterminé. Pourquoi ?
  ```c
  #include <stdio.h>

  int* foo(int step) {
      int p[9] = {0};
      for (int i = 0; i < 9; i += step) {
          p[i] = 1;
      }
      return p;
  }

  int main(int argc, char** argv) {
      int* p = foo(2);
      printf("%d\n", p[4]);
      return 0;
  }
  ```
+ Corrigez le code de la fonction `foo`, puis dessinez l'état de la mémoire juste
  avant l'exécution de l'instruction ```c return p;```.