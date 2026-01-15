def remove_multiples(lst, k):
    for i in range(2*k, len(lst), k):
        lst[i] = 0

lst = [1] * 10
remove_multiples(lst, 3)
for i in range(10):
    if (i % 3 == 0 and i > 3):
        assert(lst[i] == 0)
    else:
        assert(lst[i] == 1)
    # Code équivalent qui utilise le xor (^)
    # assert(lst[i] ^ (i % 3 == 0 and i > 3))

# Complexité temporelle de remove_multiples:
# Theta(len(lst)/k) (dans tous les cas).

def sieve_eratosthenes(m):
    """Returns a 0/1 list 'prime' of size m,
    such that prime[m] equals 1 iff m is prime."""
    is_prime = [1]*m
    is_prime[0] = is_prime[1] = 0
    p = 2
    while (p*p < m):
        if is_prime[p]:
            remove_multiples(is_prime, p)
        p+=1
    return is_prime

# Complexité temporelle de sieve_eratosthenes:
# Theta(m) (création de la liste)
# À chaque étape de la boucle:
#   Theta(m/p) si p est premier
#   Theta(1) sinon.
# Au total on obtient un algo en
# Theta(m + m/2 + m/3 + … + m/p(m)) où p(m) est le
# plus grand nombre premier ≤ sqrt(m).
# Si on veut une borne sup plus facile à exprimer : 
# O(m*'nb. de nombres premiers < sqrt(m)').

def primes(m):
    """Returns the list of prime numbers strictly smaller
    than m, in increasing order."""
    is_prime = sieve_eratosthenes(m)
    return [p for p in range(m) if is_prime[p]]

assert(primes(64) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61])
assert(primes(61)[-1] == 59)