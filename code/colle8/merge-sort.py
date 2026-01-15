def merge(lst1, lst2):
    """Merges two sorted lists into a sorted list."""
    res = []
    i = j = 0
    while (i < len(lst1) or j < len(lst2)):
        if i == len(lst1):
            res.append(lst2[j])
            j+=1
        elif j == len(lst2):
            res.append(lst1[i])
            i+=1
        elif lst1[i] < lst2[j]:
            res.append(lst1[i])
            i+=1
        else:
            res.append(lst2[j])
            j+=1
    return res

def split(lst):
    """Takes a list and splits its content into
    two lists of equal length
    (±1 if the initial list has odd length)."""
    n = len(lst)
    return lst[:n//2], lst[n//2:]

def merge_sort(lst):
    """Sorts a list using the merge sort algorithm."""
    if (len(lst) <= 1):
        return lst
    lst1, lst2 = split(lst)
    return merge(merge_sort(lst1), merge_sort(lst2))

l = [0,2,1,0,9,4,3,2,8,4,5]
print(l)
print(merge_sort(l))