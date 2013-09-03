#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs
import sys

import MySQLdb

if len(sys.argv) != 3:
	print 'ERROR: geen invoer- en uitvoerbestanden opgegeven'
	exit(1)

databaseUsername = ''
databasePassword = ''
for line in open('../.database-username', 'r'):
	databaseUsername = line.strip()
	break
for line in open('../.database-password', 'r'):
	databasePassword = line.strip()
	break

db=MySQLdb.connect(passwd=databasePassword, db='opentaal', )
c=db.cursor()

of = codecs.open(sys.argv[2], 'w', 'utf-8')
of.write('2_10\tnext_version\tword\tbase_word\talternatief\taantekeningen\n')
for line in codecs.open(sys.argv[1], 'r', 'utf-8'):
	line = line.strip().split('\t')[0].replace('\'', '\'\'')
	q = u'SELECT 2_10,next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE word = \'%s\'' %line
	c.execute(q)
	row = c.fetchone()
	if row is None:
		print 'ERROR: select kon niet vinden:', line
		exit(1)
	while row is not None:
		lookup = '\t'.join([str(v) for v in row])
		of.write('%s\n' %lookup.decode('latin1'))
		row = c.fetchone()
