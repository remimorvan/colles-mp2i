type locality = City of int | Department of int;;

let is_part_of = function
  | City(c), Department(d) -> c/1000 = d
  | _, _ -> false;;

assert(is_part_of (City(33000), Department(33)));
assert(is_part_of (City(33800), Department(33)));
assert(not (is_part_of (Department(33), City(33000))));
assert(not (is_part_of (City(75006), City(75006))));;