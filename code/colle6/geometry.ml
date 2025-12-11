type point = float * float;;
type shape = Circle of point * float | Disc of point * float;;

let belongs_to (p: point) (s: shape) = match p, s with
  | (px, py), Circle((cx, cy), r) ->
    abs_float((px-.cx)**2. +. (py-.cy)**2. -. r) <= 1E-6
  | (px, py), Disc((cx, cy), r) ->
    (px-.cx)**2. +. (py-.cy)**2. <= r;;

let angle = Float.pi/.3. in 
assert(belongs_to (cos(angle), sin(angle)) (Circle((0.,0.), 1.)));
assert(belongs_to (cos(angle), sin(angle)) (Disc((0.,0.), 1.)));
assert(not (belongs_to (cos(angle), sin(angle)) (Circle((0.,0.), 1.1))));
assert(belongs_to (cos(angle), sin(angle)) (Disc((0.,0.), 1.1)));;