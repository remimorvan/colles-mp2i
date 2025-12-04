(* But : type enregistrement pour une zone géographique *)

type zone = {
  code_postal : int;
  ville : string;
};;

let string_of_zone (z: zone) =
  (string_of_int z.code_postal) ^ " " ^ z.ville

let z = {
  code_postal = 33000;
  ville = "Bordeaux";
};;

print_endline (string_of_zone z);;

(* Type somme : déterminer si une localité fait partie d'une autre *)

type localite = Commune of int | Departement of int;;

let fait_partie_de = function
  | Commune(c), Departement(d) -> c/1000 == d
  | _, _ -> false;;

assert(fait_partie_de (Commune(33000), Departement(33)));
assert(fait_partie_de (Commune(33800), Departement(33)));
assert(not (fait_partie_de (Departement(33), Commune(33000))));
assert(not (fait_partie_de (Commune(75006), Commune(75006))));

