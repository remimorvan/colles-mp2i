type zone = {
  code_postal : int;
  ville : string;
};;

let string_of_zone (z: zone) =
  (string_of_int z.code_postal) ^ " " ^ z.ville

let bdx = {
  code_postal = 33000;
  ville = "Bordeaux";
};;

let tal = {
  code_postal = 33400;
  ville = "Talence";
};;

assert (string_of_zone bdx = "33000 Bordeaux");;
assert (string_of_zone tal = "33400 Talence");;

