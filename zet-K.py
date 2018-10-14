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

ofk = codecs.open('check-K.tsv', 'w', 'utf-8')
ofn = codecs.open('check-N.tsv', 'w', 'utf-8')
ofk.write('nieuw basiswoord, uit:\t2_10\tnext_version\tword\tbase_word\talternatief\taantekeningen\n')
ofn.write('nieuw basiswoord, uit:\t2_10\tnext_version\tword\tbase_word\talternatief\taantekeningen\n')
for line in codecs.open('K', 'r', 'utf-8'):
	line = line.strip().replace('\'', '\'\'')
	q = u'SELECT 2_10,next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE word = \'%s\' AND (next_version = \'K\' OR next_version = \'k\')' %(line)
	c.execute(q)
	row = c.fetchone()
#	if row is None:
#		print 'ERROR: select kon niet vinden:', line
#		exit(1)
	while row is not None:
		lookup = '\t'.join([str(v) for v in row])
		ofk.write('%s\t%s\n' %(line, lookup.decode('latin1')))
		row = c.fetchone()
	q = u'SELECT 2_10,next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE word = \'%s\' AND next_version <> \'K\' AND next_version <> \'k\'' %(line)
	c.execute(q)
	row = c.fetchone()
#	if row is None:
#		print 'ERROR: select kon niet vinden:', line
#		exit(1)
	while row is not None:
		lookup = '\t'.join([str(v) for v in row])
		ofn.write('%s\t%s\n' %(line, lookup.decode('latin1')))
		row = c.fetchone()
