#!/usr/bin/env python3

words = {}
compounds = {}

for line in open('alle-basiswoorden-gekeurd.txt', 'r'):
    words[line[:-1]] = None
print(len(words))

for left in sorted(words.items()):
    for right in sorted(words.items()):
        compound = '{}{}'.format(left, right)
        if compound in words and compound not in compounds:
            compounds[compound] = None
            print(compound)
print(len(compounds))
