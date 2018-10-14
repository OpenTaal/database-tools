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

of = codecs.open('nieuwe-woorden-uit-alternatieven.tsv', 'w', 'utf-8')
of.write('nieuw woord, uit:\tnext_version\tword\tbase_word\talternatief\taantekeningen\n')
for line in codecs.open('nieuwe-woorden-uit-alternatieven.txt', 'r', 'utf-8'):
	if line == '' or line == None:
		continue
	line = line.strip().split('\t')[0].replace('\'', '\'\'')
	q = u'SELECT next_version,word,base_word,alternatief,aantekeningen FROM words_list WHERE alternatief = \'%s\' OR alternatief LIKE \'%s;%%\' OR alternatief LIKE \'%%;%s\' OR alternatief LIKE \'%%;%s;%%\'' %(line, line, line, line)
#	print q.encode('utf8')
	c.execute(q.encode('utf8'))
	row = c.fetchone()
	if row is None:
		print u'WARNING: select kon niet vinden:', line.encode('utf8')
		of.write(u'%s\tGEEN INFO' %(line))
	while row is not None:
		print len(row), line.encode('utf8')
		lookup = '\t'.join([str(v) for v in row])
		of.write(u'%s\t' %(line))
#		of.write(u'%s\t' %(line.decode('latin1')))
#		of.write(u'%s\t' %(line.decode('utf8')))
#		of.write(u'%s\t' %(line.encode('utf8')))
		of.write(u'%s\n' %(lookup.decode('latin1')))
		row = c.fetchone()
