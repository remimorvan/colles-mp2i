let rec f n = 
  if n > 100 then
    n - 10
  else 
    f (f (n+11))
in for i = 0 to 100 do 
  print_endline (string_of_int (f i));
done