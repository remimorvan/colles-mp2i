let rec exp_square x n = 
  if n < 0 then (
    assert (abs_float x > 1E-15);
    exp_square (1. /. x) (-n);
  ) else if n = 0 then 
    1.
  else let y = exp_square x (n/2) in
    if n mod 2 == 0 then y *. y else x *. y *. y;;
    
assert(abs_float((exp_square 1.0 4) -. 1.0) < 1E-12);;
assert(abs_float((exp_square 2.0 4) -. 16.0) < 1E-12);;
assert(abs_float((exp_square (sqrt 2.0) 4) -. 4.0) < 1E-12);;

(* Justification de la terminaison :
Si n < 0, en un appel récursif, on se ramène à un cas où n > 0.
Si n >= 0, on prend comme variant n : l'unique appel récursif se fait pour une valeur strictement inférieure (n/2 < n dès que n > 0).
*)

(* Complexité : Complexité temporelle de la forme C(n) = C(n/2) + O(1),
donc on a C(n) = O(log n). *)

