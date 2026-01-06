let rec bij (x, y) =
  if x == 0 && y == 0 then
    0
  else 
    let last_point = (if x > 0 then (x-1, y+1) else (y-1,0))
    in (bij last_point)+1;;

assert (bij (0, 0) == 0);;
assert (bij (0, 1) == 1);;
assert (bij (1, 0) == 2);;
assert (bij (2, 0) == 5);;

(* Complexité temporelle de bij(x, y) : linéaire en f(x,y) ! f(x,y) est en fait exactement le nombre d'appels récursifs qu'on fait pour calculer bij(x,y). *)

(* La fonction bij n'est pas récursive terminale. *)

let bij_term (x, y) =
  let rec bij_term_aux (x, y) acc =
    if x == 0 && y == 0 then
      acc
    else 
      let last_point = (if x > 0 then (x-1, y+1) else (y-1,0))
      in bij_term_aux last_point (acc+1)
    in bij_term_aux (x, y) 0;;

for x = 0 to 10 do
  for y = 0 to 10 do 
    assert (bij (x, y) == bij_term (x, y))
  done
done;;

(* Formule close pour la bijection N^2 -> N. *)

let bij_clos (x, y) =
  ((x+y)*(x+y+1))/2 + x;;

for x = 0 to 10 do
  for y = 0 to 10 do 
    assert (bij (x, y) == bij_clos (x, y))
  done
done;;