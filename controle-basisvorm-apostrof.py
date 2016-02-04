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

q = u"SELECT word,base_word FROM words_list WHERE word LIKE '%''s' AND (next_version = 'F' OR next_version = 'f') AND base_word <> ''"
c.execute(q)
row = c.fetchone()
while row is not None:
	if row[0][:-2] != row[1]:
		print row[0], row[1]
#	of.write('%s\t%s\n' %(line, lookup.decode('latin1')))
	row = c.fetchone()

q = u"SELECT word,base_word FROM words_list WHERE word LIKE '%''ers' AND (next_version = 'F' OR next_version = 'f') AND base_word <> ''"
c.execute(q)
row = c.fetchone()
while row is not None:
	if row[0][:-1] != row[1]:
		print row[0], row[1]
#	of.write('%s\t%s\n' %(line, lookup.decode('latin1')))
	row = c.fetchone()
