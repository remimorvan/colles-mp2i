(* Question 1 *)

type color = Red | Green | Blue | Yellow;;
type card = Val of (color * int) | ChangeColor;;

(* Question 2 *)
let hand_can_be_emptied = [Val(Red, 2); Val(Red, 5); Val(Blue, 5)];;
let hand_cannot_be_emptied = [Val(Red, 2); Val(Red, 5); Val(Blue, 7)];;

(* Question 3 *)
let is_playable last_card new_card = match last_card, new_card with
  (* Étant donné la dernière carte jouée, détermine si une seconde carte est jouable par dessus. *)
  | _, ChangeColor -> true
  | ChangeColor, _ -> true
  | Val(c1, n1), Val(c2, n2) -> c1 = c2 || n1 = n2;;

assert(is_playable ChangeColor ChangeColor);
assert(is_playable (Val(Yellow, 2)) ChangeColor);
assert(is_playable ChangeColor (Val(Red, 5)));
assert(is_playable (Val(Red, 2)) (Val(Red, 5))); (* Same color *)
assert(is_playable (Val(Blue, 3)) (Val(Yellow, 3))); (* Same number *)
assert(is_playable (Val(Blue, 3)) (Val(Blue, 3))); (* Same card *)
assert(not (is_playable (Val(Red, 0)) (Val(Green, 9))));; (* Different color & different number *)

(* Question 4 *)
let rec greedy_play (init_card: card) (card_to_process: card list) (card_skipped: card list) =
  (* Étant donné une carte initiale, et la main d'une joueuse séparée en deux parties (l'ensemble 
  des cartes à essayer de jouer, et un ensemble de cartes qu'on sait non jouables sur la carte 
  initiale), applique une stratégie gloutonne consistant à jouer la première ecarte jouable.
  Retourne le nombre de cartes restant à la fin, après avoir appliqué itérativement cette 
  stratégie. *)
  match card_to_process with
  | [] -> List.length card_skipped
  | card_head::card_tail when is_playable init_card card_head ->
    greedy_play card_head ((List.rev card_skipped) @ card_tail) []
    (* On retourne (List.rev) les cartes passées pour préserver l'ordre initial. *)
  | card_head::card_tail ->
    greedy_play init_card card_tail (card_head::card_skipped);;

assert(greedy_play ChangeColor hand_can_be_emptied [] = 0);;
assert(greedy_play ChangeColor hand_cannot_be_emptied [] > 0);;

(* Question 5 *)

(* Complexité temporelle : dans le pire cas, pour jouer une carte on doit parcourir au pire toute la liste card_to_process. À cette occasion, on retournera une fois une liste (List.rev), qui est une opération en temps linéaire. Au total, pour joueur une seule carte, on a au pire une complexité linéaire. Au total, on obtient donc une complexité quadratique (+ le coût final de `List.length card_skipped`, qui est linéaire, et donc négligeable devant le reste de l'algo). *)

(* Pour la complexité spatiale, les taille de card_to_process + la taille de card_skipped
n'augmente jamais. Notre fonction est récursive terminale, et donc la complexité spatiale de
cette fonction est linéaire. *)

(* Question 6 *)
  
let hand_dont_be_greedy = [Val(Red, 8); ChangeColor; Val(Blue, 5); Val(Red, 3)];;
assert ((greedy_play ChangeColor hand_dont_be_greedy []) = 1);;
(* Il y a par ailleurs une statégie optimale :
on joue Val(Red, 8), puis Val(Red, 3), puis ChangeColor, puis Val(Blue, 5). *)

(* Question 7 *)

(* Idée derrière l'algo : au lieu de jouer la première carte jouable, on les teste toutes.
Bien sûr, on ne regarde que la meilleure solution (celle qui résulte en le plus petit nombre de
cartes non-jouables à la fin.) *)
let optimal_play (init_card: card) (hand: card list) =
  (* Étant données une carte initiale et une main, détermine le nombre cartes
  restants en main après avoir appliqué une stratégie optimale pour vider cette main. *)
  let rec optimal_play_aux init_card hand_to_process hand_skipped =
    match hand_to_process with
    | [] -> List.length hand_skipped
    | head::tail when is_playable init_card head ->
      (* NOUVEAU ! On compare deux options : jouer la carte, et ne pas la jouer. *)
      let sol_playing_head = optimal_play_aux head ((List.rev hand_skipped) @ tail) []
      and sol_not_playing_head = optimal_play_aux init_card tail (head::hand_skipped) in
      min sol_playing_head sol_not_playing_head
    | head::tail -> optimal_play_aux init_card tail (head::hand_skipped)
    in optimal_play_aux init_card hand [];;

(* On remarque que cette fonction n'est pas récursive terminale, contrairement à greedy_play. *)

assert(optimal_play ChangeColor hand_can_be_emptied = 0);;
assert(optimal_play ChangeColor hand_cannot_be_emptied > 0);;
assert(optimal_play ChangeColor hand_dont_be_greedy == 0);;