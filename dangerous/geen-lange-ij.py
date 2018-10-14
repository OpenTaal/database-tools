#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs
import re

patterns = (
# ija
r'(.*[Ss]ki)(jas.*)',
r'(.*[Ss]ki)(jack.*)',
# ije
r'(.*[Rr]i)(jeka.*)',
# iji
r'(.*[Ff]i)(ji.*)',
# ijo
r'(.*[Bb]i)(jou.*)',
r'(.*[Dd]i)(jon.*)',
r'(.*[Hh]olebi)(jongeren.*)',
# iju
r'(.*[Aa]nti)(juda.*)',
r'(.*[Mm]ini)(jurk.*)',
r'(.*[HhTt]i)(jum.*)',
r'(.*[Bb]ai)(jum.*)',
r'(.*[Hh]erbai)(jum.*)',
)
alles = codecs.open('alles-goed.tsv', 'r', 'utf-8')
for line in alles:
	word = line.strip().split('\t')[1]
	matches = []
	for pattern in patterns:
		match = re.search(pattern, word)
		if match and match.groups() not in matches:
			matches.append(match.groups())
	if len(matches) == 1:
		print '%s\t%s~%s' %(word, matches[0][0], matches[0][1])
	elif len(matches) > 1:
		print 'ERROR', matches
		exit(1)
