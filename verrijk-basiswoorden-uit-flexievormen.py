#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs
import MySQLdb

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

of = codecs.open('nieuwe-basiswoorden-uit-flexievormen.tsv', 'w', 'utf-8')
of.write('nieuw basiswoord, uit:\tnext_version\tword\tbase_word\talternatief\taantekeningen\n')
for line in codecs.open('nieuwe-basiswoorden-uit-flexievormen.txt', 'r', 'utf-8'):
	line = line.strip().split('\t')[0].replace('\'', '\'\'')
	q = u'SELECT next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE base_word = \'%s\' OR base_word LIKE \'%s;%%\' OR base_word LIKE \'%%;%s\' OR base_word LIKE \'%%;%s;%%\'' %(line, line, line, line)
	c.execute(q)
	row = c.fetchone()
	if row is None:
		print 'ERROR: select kon niet vinden:', line
		exit(1)
	while row is not None:
		lookup = '\t'.join([str(v) for v in row])
		of.write('%s\t%s\n' %(line, lookup.decode('latin1')))
		row = c.fetchone()
