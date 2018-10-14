#!/usr/bin/env python

from codecs import open
from googlesearch import GoogleSearch
from random import uniform
from sys import argv
from time import sleep

if __name__ == '__main__':
    if len(argv) != 3:
        print('ERROR: missing input and output filenames')
        exit(1)
    with open(argv[2], 'w', encoding='utf-8') as outputfile:
        with open(argv[1], 'r', encoding='utf-8') as inputfile:
            processed = 0
            for line in inputfile.readlines():
                line = line[:-1].encode('utf-8')
                print(line)
                count = GoogleSearch(line, use_proxy=False).count()
                line = str(count) + '\t' + line + '\n'
                outputfile.write(line.decode('utf-8'))
                processed += 1
                if processed % 100 == 0:
                    print(processed)
                sleep(uniform(7, 10))
