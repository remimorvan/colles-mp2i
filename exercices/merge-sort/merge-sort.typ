#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Tri fusion],
  language: "ocaml",
  difficulty: 1,
  themes: ("tri", "récursivité", "complexité")
)

On rappelle que le tri fusion est un algorithme de tri récursif
dont le principe est le suivant : on découpe la liste en deux,
on trie chaque moitié (récursivement), puis on fusionne les deux résultats.

Voici une implémentation partielle de cet algorithme.
```ocaml
let rec split lst = match lst with
  (* Takes a list and splits its content into
    two lists of equal length (±1 if the initial list has odd length). *)
  | [] -> ([], [])
  | h::tail ->
    let (lst1, lst2) = split tail in (h::lst2, lst1);;

let rec merge lst1 lst2 = 
  (* Merges two sorted lists into a sorted list. *)
  failwith "todo";;

let rec merge_sort lst = match lst with
  (* Sorts a list using the merge sort algorithm. *)
  | [] -> []
  | [x] -> [x]
  | _ ->
    let lst1, lst2 = split lst in 
    merge (merge_sort lst1) (merge_sort lst2);;
```
+ Écrire une fonction ```ocaml print_list: int list -> unit``` qui permet
	d'afficher une liste d'entiers. Vérifiez que la fonction `split` a bien le comportement attendu sur un ou deux exemples.
+ Implémentez la fonction `merge`, et testez les fonctions `merge` et `merge_sort`.
+ Déterminez (et *justifiez*) les complexités temporelles des fonctions `split`, `merge` et `merge_sort`.