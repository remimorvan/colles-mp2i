def count_chars_of_str(s):
    """Takes a string and returns a dictionnary
    mapping each caracter to its number of occurences in the string."""
    dict = {}
    for char in s:
        if char not in dict:
            dict[char] = 1
        else:
            dict[char] += 1
    return dict

def are_anagrams(s1, s2):
    """Checks if two strings are anagrams."""
    return count_chars_of_str(s1) == count_chars_of_str(s2)