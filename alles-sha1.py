#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs
import hashlib

sha1s = []
for line in codecs.open('keuring2013.csv', 'r', 'utf-8'):
	sha1s.append(line[:-1])

of = codecs.open('alles-gekeurd.txt', 'w', 'utf-8')
for line in codecs.open('alles.txt', 'r', 'utf-8'):
	line = line[:-1]
	print line
	line = line.encode('utf-8')
	checksum = hashlib.sha1(line).hexdigest()
	print checksum
	if checksum in sha1s:
		of.write('%s\n' %line.decode('utf-8'))#om utf te schrijven
