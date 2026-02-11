let dichotomy_search x arr =
    let rec dichotomy_search_bound x arr min max =
        if min == max then
            false
        else if min + 1 == max then
            arr.(min) == x
        else
            let avg = (min + max)/2 in
            if x < arr.(avg) then
                dichotomy_search_bound x arr min avg
            else
                dichotomy_search_bound x arr avg max
    in dichotomy_search_bound x arr 0 (Array.length arr);;

assert(not (dichotomy_search 0 [||]));
assert(dichotomy_search 3 [|3|]);
assert(dichotomy_search 5 [|5;7;11|]);
assert(not (dichotomy_search 6 [|5;7;11|]));
assert(dichotomy_search 3 [|1;3;4;11|]);
assert(not (dichotomy_search 4 [|1;3;7;11;11|]));
assert(not (dichotomy_search 4 [|1;3;11;17|]));