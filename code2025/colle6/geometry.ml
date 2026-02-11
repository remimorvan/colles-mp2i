type point = float * float;;
type shape = Circle of point * float | Disc of point * float;;

let belongs_to (p: point) (s: shape) = match p, s with
  | (px, py), Circle((cx, cy), r) ->
    (* En Ocaml les float sont encodés sur 64 bits avec la norme IEEE 754.
    Les mantisse est donc représentée sur 53 bits. 2^(-53) est environ égal à 10^(-16),
    il est donc raisonnable de choisir une précision de 10^(-15). *)
    abs_float((px-.cx)**2. +. (py-.cy)**2. -. r**2.) <= 1E-15
  | (px, py), Disc((cx, cy), r) ->
    (px-.cx)**2. +. (py-.cy)**2. <= r**2.;;

let angle = Float.pi/.3. in 
assert(belongs_to (cos(angle), sin(angle)) (Circle((0.,0.), 1.)));
assert(belongs_to (cos(angle), sin(angle)) (Disc((0.,0.), 1.)));
assert(not (belongs_to (2.*.cos(angle), 2.*.sin(angle)) (Circle((0.,0.), 2.1))));
assert(belongs_to (2.*.cos(angle), 2.*.sin(angle)) (Disc((0.,0.), 2.1)));
assert(not (belongs_to (2.2*.cos(angle), 2.2*.sin(angle)) (Disc((0.,0.), 2.1))));;